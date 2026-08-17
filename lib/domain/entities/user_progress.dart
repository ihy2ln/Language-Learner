/// A learner's FSRS review state for one [Item].
///
/// No row exists until an item has been reviewed at least once — the
/// scheduler treats a missing record as "new" and initializes it on first
/// review, so no separate new/learning/review state field is needed here.
class UserProgress {
  const UserProgress({
    required this.itemId,
    required this.stability,
    required this.difficulty,
    required this.lastReview,
    required this.dueAt,
    this.lapses = 0,
    this.reps = 0,
  });

  final String itemId;
  final double stability;
  final double difficulty;
  final DateTime lastReview;
  final DateTime dueAt;
  final int lapses;
  final int reps;

  UserProgress copyWith({
    double? stability,
    double? difficulty,
    DateTime? lastReview,
    DateTime? dueAt,
    int? lapses,
    int? reps,
  }) {
    return UserProgress(
      itemId: itemId,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      lastReview: lastReview ?? this.lastReview,
      dueAt: dueAt ?? this.dueAt,
      lapses: lapses ?? this.lapses,
      reps: reps ?? this.reps,
    );
  }
}
