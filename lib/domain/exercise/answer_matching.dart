/// Checks a typed answer against an item's accepted variations
/// (Item.answerVariants). Comparison is forgiving of the differences a
/// correct learner shouldn't be penalized for — case, surrounding
/// whitespace, and common punctuation (apostrophes, periods, question
/// marks, exclamation marks) — but not of actual spelling.
bool isCorrectAnswer(String typed, List<String> acceptedAnswers) {
  final normalizedTyped = _normalize(typed);
  return acceptedAnswers.any((answer) => _normalize(answer) == normalizedTyped);
}

String _normalize(String s) {
  return s
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r"['’.?!]"), '')
      .replaceAll(RegExp(r'\s+'), ' ');
}
