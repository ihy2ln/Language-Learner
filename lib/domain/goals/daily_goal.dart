/// One entry in a language's daily goal checklist.
///
/// Completion is always derived from real activity for the day (a
/// check-in row, review counts) — there's no separately-stored "goal
/// done" flag to fall out of sync with what actually happened.
class DailyGoal {
  const DailyGoal({required this.label, required this.isComplete});

  final String label;
  final bool isComplete;
}

/// The fixed daily goal list for now — check in, and review a handful of
/// items. Not user-configurable yet; that's a natural follow-up once
/// there's a settings surface for it.
List<DailyGoal> computeDailyGoals({
  required bool checkedInToday,
  required int itemsReviewedToday,
  int reviewGoalCount = 5,
}) {
  return [
    DailyGoal(label: 'Check in today', isComplete: checkedInToday),
    DailyGoal(
      label: 'Review $reviewGoalCount items',
      isComplete: itemsReviewedToday >= reviewGoalCount,
    ),
  ];
}
