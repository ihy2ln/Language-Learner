import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/entities/entities.dart';
import 'package:linguaforge/domain/session/session.dart';

Language _language({
  String code = 'es-419',
  Tier tier = Tier.tier1Full,
  bool hasCuratedContent = true,
  bool hasTts = true,
  bool hasAsr = true,
  bool hasPronunciationScoring = true,
  bool llmCorpusConstrained = false,
}) {
  return Language(
    code: code,
    name: 'Spanish',
    nativeName: 'Español',
    tier: tier,
    hasCuratedContent: hasCuratedContent,
    hasTts: hasTts,
    hasAsr: hasAsr,
    hasPronunciationScoring: hasPronunciationScoring,
    llmCorpusConstrained: llmCorpusConstrained,
    script: Script.latin,
    rtl: false,
  );
}

Item _vocabItem(String id, {String? audioRef}) => Item(
      id: id,
      type: ItemType.vocab,
      target: 't-$id',
      native: 'n-$id',
      audioRef: audioRef,
    );

UserProgress _progress(
  String itemId, {
  required DateTime dueAt,
  int lapses = 0,
}) {
  return UserProgress(
    itemId: itemId,
    stability: 5,
    difficulty: 5,
    lastReview: dueAt.subtract(const Duration(days: 5)),
    dueAt: dueAt,
    lapses: lapses,
  );
}

void main() {
  final now = DateTime.utc(2026, 1, 10);
  final past = now.subtract(const Duration(days: 1));
  final future = now.add(const Duration(days: 5));

  group('CapabilityFilter', () {
    const filter = CapabilityFilter();

    test('vocab supports recognition and recall, nothing else', () {
      final item = _vocabItem('v1');
      final language = _language();
      expect(
        filter.availableFor(item, language),
        {ExerciseType.recognition, ExerciseType.recall},
      );
    });

    test('sentence adds cloze only when the language has curated content', () {
      const item = Item(
        id: 's1',
        type: ItemType.sentence,
        target: 'x',
        native: 'y',
      );
      final withCurated = _language(hasCuratedContent: true);
      final withoutCurated = _language(hasCuratedContent: false);

      expect(
        filter.availableFor(item, withCurated),
        {ExerciseType.recognition, ExerciseType.recall, ExerciseType.cloze},
      );
      expect(
        filter.availableFor(item, withoutCurated),
        {ExerciseType.recognition, ExerciseType.recall},
      );
    });

    test('listening requires language TTS OR a recorded audioRef', () {
      const item = Item(
        id: 'l1',
        type: ItemType.listening,
        target: 'x',
        native: 'y',
      );
      final noTts = _language(hasTts: false);
      final noTtsWithRecording = _language(hasTts: false);
      const recordedItem = Item(
        id: 'l2',
        type: ItemType.listening,
        target: 'x',
        native: 'y',
        audioRef: 'audio/l2.mp3',
      );

      expect(filter.availableFor(item, noTts), isEmpty);
      expect(
        filter.availableFor(recordedItem, noTtsWithRecording),
        {ExerciseType.listening},
      );
      expect(
        filter.availableFor(item, _language(hasTts: true)),
        {ExerciseType.listening},
      );
    });

    test('speaking-scored requires both ASR and pronunciation scoring', () {
      const item = Item(
        id: 'p1',
        type: ItemType.pronunciation,
        target: 'x',
        native: 'y',
      );
      expect(
        filter.availableFor(
          item,
          _language(hasAsr: true, hasPronunciationScoring: false),
        ),
        {ExerciseType.speakingUnscored},
      );
      expect(
        filter.availableFor(
          item,
          _language(hasAsr: false, hasPronunciationScoring: false),
        ),
        isEmpty,
      );
      expect(
        filter.availableFor(
          item,
          _language(hasAsr: true, hasPronunciationScoring: true),
        ),
        {ExerciseType.speakingUnscored, ExerciseType.speakingScored},
      );
    });

    test('free conversation requires a configured provider', () {
      expect(
        filter.freeConversationAvailable(
          _language(),
          providerConfigured: false,
        ),
        isFalse,
      );
      expect(
        filter.freeConversationAvailable(
          _language(),
          providerConfigured: true,
        ),
        isTrue,
      );
    });

    test(
        'free conversation is never offered for a corpus-constrained '
        'language, even when a provider is configured', () {
      final antiguan = _language(
        code: 'aig',
        tier: Tier.tier0Special,
        hasTts: false,
        hasAsr: false,
        hasPronunciationScoring: false,
        llmCorpusConstrained: true,
      );
      expect(
        filter.freeConversationAvailable(antiguan, providerConfigured: true),
        isFalse,
      );
    });
  });

  group('SessionComposer.compose ordering and budgets', () {
    test('due reviews come first, oldest-due first', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);
      final items = {
        for (final id in ['a', 'b', 'c']) id: _vocabItem(id),
      };
      final progress = [
        _progress('c', dueAt: past.add(const Duration(hours: 1))),
        _progress('a', dueAt: past.subtract(const Duration(days: 2))),
        _progress('b', dueAt: past.subtract(const Duration(days: 1))),
      ];

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.map((e) => e.itemId).toList(), ['a', 'b', 'c']);
      expect(
          entries.every((e) => e.kind == SessionEntryKind.dueReview), isTrue);
    });

    test('lapsed items are placed after clean due items', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);
      final items = {
        for (final id in ['clean', 'lapsed']) id: _vocabItem(id),
      };
      final progress = [
        // Lapsed item is due earlier than the clean one, but should still
        // sort after it per the documented composition order.
        _progress('lapsed',
            dueAt: past.subtract(const Duration(days: 5)), lapses: 2),
        _progress('clean', dueAt: past, lapses: 0),
      ];

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.map((e) => e.itemId).toList(), ['clean', 'lapsed']);
      expect(entries[0].kind, SessionEntryKind.dueReview);
      expect(entries[1].kind, SessionEntryKind.lapsedReview);
    });

    test('items not yet due are excluded entirely', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);
      final items = {'a': _vocabItem('a')};
      final progress = [_progress('a', dueAt: future)];

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries, isEmpty);
    });

    test('review entries are capped at dailyReviewBudget, due before lapsed',
        () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);
      final items = {
        for (final id in ['d1', 'd2', 'l1', 'l2']) id: _vocabItem(id),
      };
      final progress = [
        _progress('d1', dueAt: past.subtract(const Duration(days: 2))),
        _progress('d2', dueAt: past.subtract(const Duration(days: 1))),
        _progress('l1',
            dueAt: past.subtract(const Duration(days: 3)), lapses: 1),
        _progress('l2',
            dueAt: past.subtract(const Duration(days: 4)), lapses: 1),
      ];

      const composer = SessionComposer(dailyReviewBudget: 3);
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.length, 3);
      expect(entries.map((e) => e.itemId).toList(), ['d1', 'd2', 'l2']);
    });

    test('new items come from the current unit, in authored order, capped', () {
      final language = _language();
      const unit = Unit(
        id: 'u1',
        title: 'Unit 1',
        itemIds: ['n1', 'n2', 'n3', 'n4'],
      );
      final items = {
        for (final id in ['n1', 'n2', 'n3', 'n4']) id: _vocabItem(id),
      };

      const composer = SessionComposer(dailyNewItemBudget: 2);
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: const [],
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.map((e) => e.itemId).toList(), ['n1', 'n2']);
      expect(
        entries.every((e) => e.kind == SessionEntryKind.newItem),
        isTrue,
      );
    });

    test('items already reviewed are not reintroduced as new items', () {
      final language = _language();
      const unit = Unit(
        id: 'u1',
        title: 'Unit 1',
        itemIds: ['n1', 'n2'],
      );
      final items = {
        for (final id in ['n1', 'n2']) id: _vocabItem(id),
      };
      final progress = [_progress('n1', dueAt: future)];

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.map((e) => e.itemId).toList(), ['n2']);
    });

    test('composition order is due, lapsed, new, then conversation', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: ['new1']);
      final items = {
        'due1': _vocabItem('due1'),
        'lapsed1': _vocabItem('lapsed1'),
        'new1': _vocabItem('new1'),
      };
      final progress = [
        _progress('due1', dueAt: past),
        _progress('lapsed1', dueAt: past, lapses: 1),
      ];

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: progress,
        now: now,
        conversationProviderConfigured: true,
      );

      expect(
        entries.map((e) => e.kind).toList(),
        [
          SessionEntryKind.dueReview,
          SessionEntryKind.lapsedReview,
          SessionEntryKind.newItem,
          SessionEntryKind.conversation,
        ],
      );
      expect(entries.last.itemId, isNull);
      expect(entries.last.availableExercises, {ExerciseType.freeConversation});
    });

    test('conversation entry is omitted when no provider is configured', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: const {},
        progress: const [],
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries, isEmpty);
    });

    test(
        'conversation entry is omitted for a corpus-constrained language '
        'even with a provider configured', () {
      final antiguan = _language(
        code: 'aig',
        tier: Tier.tier0Special,
        llmCorpusConstrained: true,
      );
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);

      const composer = SessionComposer();
      final entries = composer.compose(
        language: antiguan,
        currentUnit: unit,
        itemsById: const {},
        progress: const [],
        now: now,
        conversationProviderConfigured: true,
      );

      expect(entries, isEmpty);
    });

    test('an entry carries its capability-filtered exercise set', () {
      final language = _language(hasCuratedContent: false);
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: ['s1']);
      final items = {
        's1': const Item(
          id: 's1',
          type: ItemType.sentence,
          target: 'x',
          native: 'y',
        ),
      };

      const composer = SessionComposer();
      final entries = composer.compose(
        language: language,
        currentUnit: unit,
        itemsById: items,
        progress: const [],
        now: now,
        conversationProviderConfigured: false,
      );

      expect(entries.single.availableExercises,
          {ExerciseType.recognition, ExerciseType.recall});
    });

    test('a due item missing from the catalog is skipped, not thrown', () {
      final language = _language();
      const unit = Unit(id: 'u1', title: 'Unit 1', itemIds: []);
      final progress = [_progress('ghost', dueAt: past)];

      const composer = SessionComposer();
      expect(
        () => composer.compose(
          language: language,
          currentUnit: unit,
          itemsById: const {},
          progress: progress,
          now: now,
          conversationProviderConfigured: false,
        ),
        returnsNormally,
      );
    });
  });
}
