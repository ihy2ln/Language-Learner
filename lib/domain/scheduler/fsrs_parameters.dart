/// Tunable inputs to [FsrsScheduler].
///
/// ARCHITECTURE.md specifies FSRS but names no parameter set, target
/// retention, or interval bounds — none of that is defined anywhere in the
/// project docs. [defaultWeights] below is seeded from the publicly
/// published FSRS-4.5 default parameter vector (open-spaced-repetition
/// project), with the two short-term/same-day terms dropped since this
/// scheduler does not model same-day re-review (see [FsrsScheduler] doc
/// comment). Treat these seventeen values as a placeholder, not a verified
/// constant — recalibrate against the current upstream release, or against
/// this project's own review logs once they exist, before relying on them
/// for real retention accuracy. CLAUDE.md asks that changes to "the FSRS
/// algorithm or its parameters" be raised with the user first; this
/// applies to that going forward, from this initial value.
class FsrsParameters {
  const FsrsParameters({
    this.weights = defaultWeights,
    this.requestRetention = 0.9,
    this.minIntervalDays = 1,
    this.maximumIntervalDays = 36500,
  });

  /// w[0..16]. See class doc — provisional, needs verification.
  final List<double> weights;

  /// Target probability of recall at the scheduled review. FSRS defines
  /// stability as "days until retrievability decays to this value", so it
  /// also appears directly in the retrievability/interval formulas.
  final double requestRetention;

  final int minIntervalDays;

  /// ~100 years — a sanity cap, not a documented requirement.
  final int maximumIntervalDays;

  static const List<double> defaultWeights = [
    0.4072, 1.1829, 3.1262, 15.4722, // w0-3: initial stability by grade
    7.2102, 0.5316, 1.0651, 0.0234, // w4-7: initial/updated difficulty
    1.616, 0.1544, 1.0824, 1.9813, // w8-11: post-success stability
    0.0953, 0.2975, 2.2042, // w12-14: post-lapse stability
    0.2407, 2.9466, // w15-16: hard penalty, easy bonus
  ];
}
