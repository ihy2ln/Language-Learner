/// How an item is presented for review: pick from options, or type the
/// answer.
enum ExerciseFormat { multipleChoice, typed }

/// Picks the exercise format for an item from [lapses] — how many times
/// it's been graded Again (domain/scheduler/UserProgress.lapses). 0 for a
/// brand-new item, so a first exposure is never a typing test.
///
/// This deliberately reads lapses rather than raw FSRS difficulty: under
/// the default weights, difficulty starts around 6.7-8.3 on its 1-10
/// scale for *any* first grade (including Easy) and only drifts slowly
/// from there, so a fixed difficulty cutoff would misclassify almost
/// every reviewed item as "hard" regardless of how the learner is
/// actually doing. Lapse count is a direct, weight-independent read on
/// "have you actually gotten this wrong" — easy/medium (never lapsed) is
/// multiple choice; hard/very hard (lapsed at least once) is typed, so
/// the words giving real trouble get active recall instead of
/// recognition.
ExerciseFormat exerciseFormatFor({required int lapses}) {
  return lapses > 0 ? ExerciseFormat.typed : ExerciseFormat.multipleChoice;
}
