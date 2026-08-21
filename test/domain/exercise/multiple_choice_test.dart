import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/exercise/multiple_choice.dart';

void main() {
  test('always includes the correct answer', () {
    final options = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['goodbye', 'please', 'thank you'],
      random: Random(1),
    );

    expect(options, contains('hi'));
  });

  test('caps at optionCount when the pool has enough distractors', () {
    final options = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['goodbye', 'please', 'thank you', 'sorry', 'yes'],
      optionCount: 4,
      random: Random(1),
    );

    expect(options, hasLength(4));
    expect(options.toSet(), hasLength(4));
  });

  test('never duplicates the correct answer even if it appears in the pool',
      () {
    final options = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['hi', 'goodbye', 'please'],
      optionCount: 4,
      random: Random(1),
    );

    expect(options.where((o) => o == 'hi'), hasLength(1));
  });

  test('shrinks gracefully when the pool has fewer distractors than needed',
      () {
    final options = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['goodbye'],
      optionCount: 4,
      random: Random(1),
    );

    expect(options.toSet(), {'hi', 'goodbye'});
  });

  test('with the same seed, the option order is deterministic', () {
    final first = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['goodbye', 'please', 'thank you'],
      random: Random(42),
    );
    final second = buildMultipleChoiceOptions(
      correctAnswer: 'hi',
      pool: ['goodbye', 'please', 'thank you'],
      random: Random(42),
    );

    expect(first, second);
  });
}
