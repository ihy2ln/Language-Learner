import 'dart:math' as math;

import '../entities/user_progress.dart';
import 'fsrs_parameters.dart';
import 'grade.dart';

/// Free Spaced Repetition Scheduler.
///
/// Pure Dart, no Flutter and no I/O — this is the correctness core of the
/// app (ARCHITECTURE.md) and must stay unit-testable in isolation.
///
/// This implements the FSRS-4.5 formulas (17 weights): initial
/// stability/difficulty from the first grade, then per-review
/// stability/difficulty updates split into a "success" branch
/// (Hard/Good/Easy) and a "lapse" branch (Again), against a fixed
/// power-law forgetting curve. It does **not** implement the later
/// same-day/short-term stability terms (w17, w18 in FSRS-4.5+) — this app
/// reviews on a daily cadence and doesn't model sub-day re-review, so
/// those are out of scope rather than silently wrong. See
/// [FsrsParameters] for why the default weights are provisional.
///
/// A missing [UserProgress] record means "new" — there is no separate
/// New/Learning/Review/Relearning state field on the entity; see
/// [UserProgress] doc comment.
class FsrsScheduler {
  const FsrsScheduler({this.parameters = const FsrsParameters()});

  final FsrsParameters parameters;

  /// Exponent of the power-law forgetting curve. Fixed by the FSRS
  /// definition of stability (not user-configurable).
  static const double _decay = -0.5;

  /// Derived so that retrievability at t == stability is exactly 0.9 —
  /// the FSRS definition of what "stability" means. Equal to 19/81.
  static final double _factor = math.pow(0.9, 1 / _decay).toDouble() - 1;

  /// Probability of recall after [elapsedDays] since a review that left
  /// the item at the given [stability].
  double retrievability({
    required double elapsedDays,
    required double stability,
  }) {
    if (stability <= 0) return 0;
    if (elapsedDays <= 0) return 1;
    return math.pow(1 + _factor * elapsedDays / stability, _decay).toDouble();
  }

  /// Days until retrievability decays to [FsrsParameters.requestRetention],
  /// clamped to the configured min/max interval.
  double intervalDaysForStability(double stability) {
    final r = parameters.requestRetention;
    final raw = stability / _factor * (math.pow(r, 1 / _decay) - 1);
    return raw
        .clamp(
          parameters.minIntervalDays.toDouble(),
          parameters.maximumIntervalDays.toDouble(),
        )
        .toDouble();
  }

  double _initialStability(Grade grade) => parameters.weights[grade.value - 1];

  double _initialDifficulty(Grade grade) {
    final w = parameters.weights;
    final d = w[4] - (grade.value - 3) * w[5];
    return d.clamp(1.0, 10.0).toDouble();
  }

  double get _easyInitialDifficulty => _initialDifficulty(Grade.easy);

  double _nextDifficulty(double difficulty, Grade grade) {
    final w = parameters.weights;
    final deltaD = -w[6] * (grade.value - 3);
    final d1 = difficulty + deltaD * (10 - difficulty) / 9;
    final reverted = w[7] * _easyInitialDifficulty + (1 - w[7]) * d1;
    return reverted.clamp(1.0, 10.0).toDouble();
  }

  double _nextStabilityOnSuccess({
    required double stability,
    required double difficulty,
    required double retrievability,
    required Grade grade,
  }) {
    final w = parameters.weights;
    final hardPenalty = grade == Grade.hard ? w[15] : 1.0;
    final easyBonus = grade == Grade.easy ? w[16] : 1.0;
    final inc = 1 +
        math.exp(w[8]) *
            (11 - difficulty) *
            math.pow(stability, -w[9]) *
            (math.exp((1 - retrievability) * w[10]) - 1) *
            hardPenalty *
            easyBonus;
    return stability * inc;
  }

  double _nextStabilityOnLapse({
    required double stability,
    required double difficulty,
    required double retrievability,
  }) {
    final w = parameters.weights;
    final sFail = w[11] *
        math.pow(difficulty, -w[12]) *
        (math.pow(stability + 1, w[13]) - 1) *
        math.exp((1 - retrievability) * w[14]);
    // A lapse should not leave the item more stable than it was — guards
    // against parameter values that could otherwise invert this.
    return math.min(sFail, stability);
  }

  /// Applies [grade] to [current] (or initializes a new item when `current`
  /// is `null`) and returns the resulting progress, including the next
  /// [UserProgress.dueAt].
  UserProgress review({
    required String itemId,
    required UserProgress? current,
    required Grade grade,
    required DateTime now,
  }) {
    if (current == null) {
      final stability = math.max(_initialStability(grade), 0.01);
      final difficulty = _initialDifficulty(grade);
      final interval = intervalDaysForStability(stability);
      return UserProgress(
        itemId: itemId,
        stability: stability,
        difficulty: difficulty,
        lastReview: now,
        dueAt: now.add(Duration(days: interval.round())),
        lapses: grade == Grade.again ? 1 : 0,
        reps: 1,
      );
    }

    final elapsedDays = now.difference(current.lastReview).inHours / 24.0;
    final r = retrievability(
      elapsedDays: elapsedDays,
      stability: current.stability,
    );

    final nextDifficulty = _nextDifficulty(current.difficulty, grade);
    final rawNextStability = grade == Grade.again
        ? _nextStabilityOnLapse(
            stability: current.stability,
            difficulty: current.difficulty,
            retrievability: r,
          )
        : _nextStabilityOnSuccess(
            stability: current.stability,
            difficulty: current.difficulty,
            retrievability: r,
            grade: grade,
          );
    final nextStability = math.max(rawNextStability, 0.01);
    final interval = intervalDaysForStability(nextStability);

    return current.copyWith(
      stability: nextStability,
      difficulty: nextDifficulty,
      lastReview: now,
      dueAt: now.add(Duration(days: interval.round())),
      lapses: grade == Grade.again ? current.lapses + 1 : current.lapses,
      reps: current.reps + 1,
    );
  }
}
