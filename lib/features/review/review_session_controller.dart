import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/scheduler/scheduler.dart';
import '../../domain/session/session.dart';
import 'review_session_state.dart';

class ReviewSessionController
    extends FamilyAsyncNotifier<ReviewSessionState, String> {
  final FsrsScheduler _scheduler = const FsrsScheduler();
  late final ProgressRepository _progressRepository;
  late final String _languageCode;

  @override
  Future<ReviewSessionState> build(String languageCode) async {
    _languageCode = languageCode;

    final db = ref.watch(databaseProvider);
    await ensureSeedContent(db);

    _progressRepository = ref.watch(progressRepositoryProvider);
    final languageRepository = ref.watch(languageRepositoryProvider);
    final contentRepository = ref.watch(contentRepositoryProvider);

    final language = (await languageRepository.getByCode(languageCode))
        .when(ok: (l) => l, err: (e) => throw StateError(e.message));

    final bundle = (await contentRepository.getBundle(languageCode))
        .when(ok: (b) => b, err: (e) => throw StateError(e.message));
    final unit = bundle.units.single;

    final itemsById = {
      for (final itemId in unit.itemIds)
        itemId: (await contentRepository.getItem(languageCode, itemId))
            .when(ok: (item) => item, err: (e) => throw StateError(e.message)),
    };

    final progress = (await _progressRepository.getAllForLanguage(
      languageCode,
    ))
        .when(ok: (p) => p, err: (e) => throw StateError(e.message));

    const composer = SessionComposer();
    final entries = composer.compose(
      language: language,
      currentUnit: unit,
      itemsById: itemsById,
      progress: progress,
      now: DateTime.now(),
      conversationProviderConfigured: false,
    );

    return ReviewSessionState(
      language: language,
      itemsById: itemsById,
      entries: entries,
      lapsesByItemId: {
        for (final p in progress) p.itemId: p.lapses,
      },
      currentIndex: 0,
      reviewedCount: 0,
      correctCount: 0,
      // No prior progress at all means this is the learner's first-ever
      // session for the language — SessionComposer naturally composes an
      // all-new-item session in that case, which doubles as a placement
      // test with no domain-layer changes.
      isPlacementTest: progress.isEmpty,
    );
  }

  /// Records the outcome of the current card (correct/incorrect, as
  /// determined by the multiple-choice selection or typed-answer match)
  /// and advances to the next one. There's no separate self-report grade
  /// step anymore — the exercise format (domain/exercise) already decided
  /// how the answer was captured, so correctness maps straight to Good or
  /// Again.
  Future<void> submitAnswer({required bool wasCorrect}) async {
    final current = state.valueOrNull;
    if (current == null || current.isFinished) return;

    final itemId = current.currentEntry?.itemId;
    if (itemId != null) {
      final existing =
          (await _progressRepository.getForItem(_languageCode, itemId))
              .valueOrNull;
      final updated = _scheduler.review(
        itemId: itemId,
        current: existing,
        grade: wasCorrect ? Grade.good : Grade.again,
        now: DateTime.now(),
      );
      await _progressRepository.save(_languageCode, updated);
    }

    state = AsyncData(current.copyWith(
      currentIndex: current.currentIndex + 1,
      reviewedCount: current.reviewedCount + 1,
      correctCount: current.correctCount + (wasCorrect ? 1 : 0),
    ));
  }
}

final reviewSessionControllerProvider = AsyncNotifierProvider.family<
    ReviewSessionController, ReviewSessionState, String>(
  ReviewSessionController.new,
);
