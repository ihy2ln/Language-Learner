import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/exercise/exercise.dart';
import 'quiz_state.dart';

/// A fixed-length multiple-choice quiz over one language's seeded items —
/// on-demand practice, not spaced repetition. No FSRS grading and no
/// progress writes; the score exists only for this round.
class QuizController extends FamilyAsyncNotifier<QuizState, String> {
  static const _questionCount = 8;

  @override
  Future<QuizState> build(String languageCode) async {
    final db = ref.watch(databaseProvider);
    await ensureSeedContent(db);

    final languageRepository = ref.watch(languageRepositoryProvider);
    final contentRepository = ref.watch(contentRepositoryProvider);

    final language = (await languageRepository.getByCode(languageCode))
        .when(ok: (l) => l, err: (e) => throw StateError(e.message));
    final bundle = (await contentRepository.getBundle(languageCode))
        .when(ok: (b) => b, err: (e) => throw StateError(e.message));
    final unit = bundle.units.single;

    final items = [
      for (final itemId in unit.itemIds)
        (await contentRepository.getItem(languageCode, itemId))
            .when(ok: (item) => item, err: (e) => throw StateError(e.message)),
    ];

    final selected = pickRandomItems(items, count: _questionCount);
    final questions = [
      for (final item in selected)
        QuizQuestion(
          item: item,
          options: buildMultipleChoiceOptions(
            correctAnswer: item.native,
            pool: [
              for (final other in items)
                if (other.id != item.id) other.native,
            ],
          ),
        ),
    ];

    return QuizState(
      language: language,
      questions: questions,
      currentIndex: 0,
      correctCount: 0,
    );
  }

  void answer({required bool wasCorrect}) {
    final current = state.valueOrNull;
    if (current == null || current.isFinished) return;

    state = AsyncData(current.copyWith(
      currentIndex: current.currentIndex + 1,
      correctCount: current.correctCount + (wasCorrect ? 1 : 0),
    ));
  }
}

final quizControllerProvider =
    AsyncNotifierProvider.family<QuizController, QuizState, String>(
  QuizController.new,
);
