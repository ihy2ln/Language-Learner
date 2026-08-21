import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/exercise/quiz_selection.dart';

void main() {
  test('caps at count when there are enough items', () {
    final picked = pickRandomItems([1, 2, 3, 4, 5], count: 3, random: Random(1));

    expect(picked, hasLength(3));
    expect(picked.toSet(), everyElement(inInclusiveRange(1, 5)));
  });

  test('never repeats an item', () {
    final picked = pickRandomItems([1, 2, 3, 4, 5], count: 5, random: Random(1));

    expect(picked.toSet(), hasLength(5));
  });

  test('shrinks gracefully when there are fewer items than count', () {
    final picked = pickRandomItems([1, 2], count: 8, random: Random(1));

    expect(picked.toSet(), {1, 2});
  });

  test('with the same seed, the pick is deterministic', () {
    final first = pickRandomItems([1, 2, 3, 4, 5], count: 3, random: Random(7));
    final second = pickRandomItems([1, 2, 3, 4, 5], count: 3, random: Random(7));

    expect(first, second);
  });
}
