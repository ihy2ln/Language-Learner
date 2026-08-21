/// How an item is presented for review: pick from options, or type the
/// answer.
enum ExerciseFormat { multipleChoice, typed }

/// Difficulty midpoint between the FSRS scale's easy/medium and hard/very
/// hard halves. Like the FSRS weights themselves, this is a reasonable
/// starting point, not a calibrated cutoff.
const _hardThreshold = 5.5;

/// Picks the exercise format for an item from its FSRS difficulty
/// (domain/scheduler — clamped to [1, 10], higher is harder). An item with
/// no prior progress yet (a brand-new item, e.g. in a placement test) has
/// no difficulty to read, so it defaults to multiple choice — a first
/// exposure to a word shouldn't ambush the learner with a typing test.
ExerciseFormat exerciseFormatFor(double? difficulty) {
  if (difficulty == null || difficulty < _hardThreshold) {
    return ExerciseFormat.multipleChoice;
  }
  return ExerciseFormat.typed;
}
