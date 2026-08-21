import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/content/seed_loader.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/data/repositories/drift_progress_repository.dart';
import 'package:linguaforge/domain/entities/entities.dart';
import 'package:linguaforge/features/languages/language_home_screen.dart';
import 'package:linguaforge/providers/speech/speech_providers.dart';

import '../../providers/speech/fake_tts_adapter.dart';

/// End-to-end widget coverage of the Spanish review flow: open the app,
/// start a session for the seeded unit, work through every card, and land
/// on a completion screen (the placement-results screen, since a fresh
/// database has no prior progress). Every item starts with zero lapses,
/// so a fresh session is always multiple choice
/// (domain/exercise/exercise_format.dart) — that's exercised here; the
/// typed-answer path (for items that have lapsed before) gets its own
/// coverage below. This is the substitute for manually tapping through
/// the app on a device — this sandbox has no Android SDK/emulator to do
/// that with.
void main() {
  // Each test opens its own AppDatabase(NativeDatabase.memory()) for
  // isolation, which is exactly the pattern Drift warns about (it assumes
  // one long-lived instance in production, which databaseProvider does
  // provide there — this file just doesn't share a database across tests
  // on purpose).
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  Widget appUnderTest({FakeTtsAdapter? tts}) {
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
        if (tts != null) ttsAdapterProvider.overrideWithValue(tts),
      ],
      child: const MaterialApp(
        home: LanguageHomeScreen(languageCode: 'es-419'),
      ),
    );
  }

  /// Taps the multiple-choice option matching [correctAnswer], then
  /// Continue — the flow for every card in a fresh session. The card
  /// scrolls (SingleChildScrollView), so longer content can push a button
  /// below the test viewport — ensureVisible before each tap.
  Future<void> answerCorrectly(WidgetTester tester, String correctAnswer) async {
    final optionFinder = find.byKey(Key('mc-option-$correctAnswer'));
    await tester.ensureVisible(optionFinder);
    await tester.tap(optionFinder);
    await tester.pump();
    final continueFinder = find.byKey(const Key('continue-button'));
    await tester.ensureVisible(continueFinder);
    await tester.tap(continueFinder);
    await tester.pumpAndSettle();
  }

  testWidgets('home screen shows the seeded language and a start button',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Español'), findsOneWidget);
    expect(find.text('Greetings and introductions · A1'), findsOneWidget);
    expect(find.byKey(const Key('start-review-button')), findsOneWidget);
  });

  testWidgets(
      'starting a review shows the first seeded item as multiple choice',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    expect(find.text('1 / 12'), findsOneWidget);
    expect(find.byKey(const Key('review-target-text')), findsOneWidget);
    expect(find.text('buenos días'), findsOneWidget);
    expect(find.byKey(const Key('mc-option-good morning')), findsOneWidget);
    // No typed-answer field on a never-lapsed item.
    expect(find.byKey(const Key('typed-answer-field')), findsNothing);
    // Not answered yet.
    expect(find.byKey(const Key('answer-feedback')), findsNothing);
  });

  testWidgets('selecting the right option shows correct feedback',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('mc-option-good morning')));
    await tester.pump();

    expect(find.byKey(const Key('answer-feedback')), findsOneWidget);
    expect(find.text('Correct!'), findsOneWidget);
    expect(find.byKey(const Key('continue-button')), findsOneWidget);
  });

  testWidgets('selecting the wrong option shows the correct answer',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    // Any option that isn't "good morning" is wrong for item i001.
    final wrongOption = find
        .byWidgetPredicate((w) =>
            w is OutlinedButton &&
            w.key is ValueKey &&
            (w.key! as ValueKey).value.toString().startsWith('mc-option-') &&
            (w.key! as ValueKey).value != 'mc-option-good morning')
        .first;
    await tester.tap(wrongOption);
    await tester.pump();

    expect(find.byKey(const Key('answer-feedback')), findsOneWidget);
    expect(find.textContaining('Not quite'), findsOneWidget);
    expect(find.textContaining('good morning'), findsWidgets);
  });

  testWidgets('continuing advances to the next card, unanswered',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    await answerCorrectly(tester, 'good morning');

    expect(find.text('2 / 12'), findsOneWidget);
    expect(find.text('buenas tardes'), findsOneWidget);
    expect(find.byKey(const Key('answer-feedback')), findsNothing);
  });

  testWidgets(
      'working through all 12 seeded items on a fresh language reaches the '
      'placement results screen', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    const natives = [
      'good morning',
      'good afternoon',
      'good night',
      'hi',
      'goodbye',
      'please',
      'thank you',
      "you're welcome",
      'how are you',
      'how are you',
      'nice to meet you',
      'my name is...',
    ];
    for (final native in natives) {
      expect(find.byKey(const Key('placement-results')), findsNothing);
      await answerCorrectly(tester, native);
    }

    expect(find.byKey(const Key('placement-results')), findsOneWidget);
    expect(find.text('12 / 12 correct'), findsOneWidget);
    expect(
      find.text('Confident — you know most of this'),
      findsOneWidget,
    );
  });

  testWidgets('Done on the placement results screen returns to the home '
      'screen', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    const natives = [
      'good morning',
      'good afternoon',
      'good night',
      'hi',
      'goodbye',
      'please',
      'thank you',
      "you're welcome",
      'how are you',
      'how are you',
      'nice to meet you',
      'my name is...',
    ];
    for (final native in natives) {
      await answerCorrectly(tester, native);
    }

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('start-review-button')), findsOneWidget);
  });

  testWidgets('a language with TTS shows a pronunciation button on the card',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('tts-button')), findsOneWidget);
  });

  testWidgets('tapping the pronunciation button speaks the target word',
      (tester) async {
    final fakeTts = FakeTtsAdapter();
    await tester.pumpWidget(appUnderTest(tts: fakeTts));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('tts-button')));
    await tester.pump();

    expect(fakeTts.spokenCalls, [(text: 'buenos días', voiceHint: 'es-MX')]);
  });

  testWidgets(
      'an item that has lapsed before shows a typed-answer field, not '
      'multiple choice', (tester) async {
    // Seed a due, once-lapsed progress row for i001 directly — going
    // through two real sessions to reach this state isn't reliable here,
    // since a fresh lapse's next dueAt lands tomorrow (FSRS's minimum
    // interval), not later today.
    final db = AppDatabase(NativeDatabase.memory());
    await ensureSeedContent(db);
    await DriftProgressRepository(db).save(
      'es-419',
      UserProgress(
        itemId: 'es-a1-01-i001',
        stability: 0.4,
        difficulty: 8,
        lastReview: DateTime.now().subtract(const Duration(days: 2)),
        dueAt: DateTime.now().subtract(const Duration(days: 1)),
        lapses: 1,
        reps: 1,
      ),
    );

    await tester.pumpWidget(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const MaterialApp(
        home: LanguageHomeScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    // Due items are ordered before new ones, so the lapsed i001 (the only
    // due item) is first.
    expect(find.text('buenos días'), findsOneWidget);
    expect(find.byKey(const Key('typed-answer-field')), findsOneWidget);
    expect(find.byKey(const Key('mc-option-good morning')), findsNothing);

    await tester.enterText(
      find.byKey(const Key('typed-answer-field')),
      'good morning',
    );
    await tester.tap(find.byKey(const Key('submit-typed-button')));
    await tester.pump();

    expect(find.text('Correct!'), findsOneWidget);
  });
}
