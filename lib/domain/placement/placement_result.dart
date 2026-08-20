/// Qualitative read on a placement-test score. This is a simple
/// percent-correct heuristic, not a real proficiency assessment — same
/// spirit as the FSRS weights being flagged provisional elsewhere in
/// domain/: it's a reasonable starting point, not a calibrated model.
enum PlacementBand { beginner, developing, confident }

class PlacementResult {
  const PlacementResult({
    required this.band,
    required this.scorePercent,
    required this.planSummary,
  });

  final PlacementBand band;

  /// 0-100.
  final double scorePercent;

  /// One or two sentences describing what happens next.
  final String planSummary;
}

PlacementResult computePlacementResult({
  required int correctCount,
  required int totalCount,
}) {
  final percent =
      totalCount == 0 ? 0.0 : (correctCount / totalCount) * 100;

  if (percent >= 80) {
    return PlacementResult(
      band: PlacementBand.confident,
      scorePercent: percent,
      planSummary: 'You already know most of this unit. It will move '
          'into your regular spaced-review rotation quickly, and new '
          'units will be introduced sooner.',
    );
  }
  if (percent >= 50) {
    return PlacementResult(
      band: PlacementBand.developing,
      scorePercent: percent,
      planSummary: "You've got a real start here. Short daily reviews "
          "will fill in the gaps before you move on to new material.",
    );
  }
  return PlacementResult(
    band: PlacementBand.beginner,
    scorePercent: percent,
    planSummary: "This unit is new territory, which is exactly what a "
        'placement test is for. Expect frequent, short reviews of these '
        'items over the next few days.',
  );
}
