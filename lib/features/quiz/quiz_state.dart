import '../../domain/entities/entities.dart';

/// One quiz question: an item plus its shuffled multiple-choice options
/// (already built — not recomputed on every rebuild).
class QuizQuestion {
  const QuizQuestion({required this.item, required this.options});

  final Item item;
  final List<String> options;
}

/// State for one standalone quiz round: a fixed set of questions, answered
/// in order, ending in a score. Independent of spaced repetition — no
/// FSRS grading, no progress writes, just "how many did you get right."
class QuizState {
  const QuizState({
    required this.language,
    required this.questions,
    required this.currentIndex,
    required this.correctCount,
  });

  final Language language;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int correctCount;

  bool get isFinished => currentIndex >= questions.length;

  QuizQuestion? get currentQuestion =>
      isFinished ? null : questions[currentIndex];

  QuizState copyWith({int? currentIndex, int? correctCount}) {
    return QuizState(
      language: language,
      questions: questions,
      currentIndex: currentIndex ?? this.currentIndex,
      correctCount: correctCount ?? this.correctCount,
    );
  }
}
