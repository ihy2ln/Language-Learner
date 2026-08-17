import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/scheduler/scheduler.dart';
import '../../domain/session/session.dart';
import 'review_session_state.dart';

/// Hardcoded to the one seeded language/unit for this vertical slice —
/// there is no language picker yet (deliberately: "one language, working
/// completely" before the list grows).
const _languageCode = 'es-419';

class ReviewSessionController extends AsyncNotifier<ReviewSessionState> {
  final FsrsScheduler _scheduler = const FsrsScheduler();
  late final ProgressRepository _progressRepository;

  @override
  Future<ReviewSessionState> build() async {
    final db = ref.watch(databaseProvider);
    await ensureSeedContent(db);

    _progressRepository = ref.watch(progressRepositoryProvider);
    final languageRepository = ref.watch(languageRepositoryProvider);
    final contentRepository = ref.watch(contentRepositoryProvider);

    final language = (await languageRepository.getByCode(_languageCode))
        .when(ok: (l) => l, err: (e) => throw StateError(e.message));

    final bundle = (await contentRepository.getBundle(_languageCode))
        .when(ok: (b) => b, err: (e) => throw StateError(e.message));
    final unit = bundle.units.single;

    final itemsById = {
      for (final itemId in unit.itemIds)
        itemId: (await contentRepository.getItem(_languageCode, itemId))
            .when(ok: (item) => item, err: (e) => throw StateError(e.message)),
    };

    final progress = (await _progressRepository.getAllForLanguage(
      _languageCode,
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
      currentIndex: 0,
      revealed: false,
      reviewedCount: 0,
    );
  }

  void reveal() {
    final current = state.valueOrNull;
    if (current == null || current.isFinished || current.revealed) return;
    state = AsyncData(current.copyWith(revealed: true));
  }

  Future<void> grade(Grade grade) async {
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
        grade: grade,
        now: DateTime.now(),
      );
      await _progressRepository.save(_languageCode, updated);
    }

    state = AsyncData(current.copyWith(
      currentIndex: current.currentIndex + 1,
      revealed: false,
      reviewedCount: current.reviewedCount + 1,
    ));
  }
}

final reviewSessionControllerProvider =
    AsyncNotifierProvider<ReviewSessionController, ReviewSessionState>(
  ReviewSessionController.new,
);
