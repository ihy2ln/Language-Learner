import 'dart:math';

/// Builds a shuffled multiple-choice option list: [correctAnswer] plus up
/// to `optionCount - 1` distractors drawn from [pool] (typically the
/// native-language text of other items in the same unit). If [pool]
/// doesn't have enough distinct alternatives, the list is simply shorter
/// than [optionCount] — never padded with anything fake.
///
/// [random] is injectable for deterministic tests; production callers
/// leave it unset.
List<String> buildMultipleChoiceOptions({
  required String correctAnswer,
  required List<String> pool,
  int optionCount = 4,
  Random? random,
}) {
  final rng = random ?? Random();
  final distractors = pool.where((p) => p != correctAnswer).toSet().toList()
    ..shuffle(rng);

  final options = [correctAnswer, ...distractors.take(optionCount - 1)];
  options.shuffle(rng);
  return options;
}
