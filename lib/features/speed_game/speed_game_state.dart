import '../../domain/entities/entities.dart';

/// State for one speed-flashcard round: race the clock, self-report
/// known/missed on each card, no FSRS grading and no progress writes —
/// this is a drill, not a review session.
class SpeedGameState {
  const SpeedGameState({
    required this.language,
    required this.words,
    required this.currentIndex,
    required this.revealed,
    required this.score,
    required this.secondsRemaining,
    required this.isRunning,
  });

  final Language language;

  /// The word pool, shuffled once at round start. Cycles ([currentWord])
  /// rather than ending early if the round outlasts the pool.
  final List<Item> words;

  final int currentIndex;
  final bool revealed;
  final int score;
  final int secondsRemaining;
  final bool isRunning;

  bool get isFinished => !isRunning;

  Item get currentWord => words[currentIndex % words.length];

  SpeedGameState copyWith({
    int? currentIndex,
    bool? revealed,
    int? score,
    int? secondsRemaining,
    bool? isRunning,
  }) {
    return SpeedGameState(
      language: language,
      words: words,
      currentIndex: currentIndex ?? this.currentIndex,
      revealed: revealed ?? this.revealed,
      score: score ?? this.score,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
