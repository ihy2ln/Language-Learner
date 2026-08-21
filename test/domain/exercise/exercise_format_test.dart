import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/exercise/exercise_format.dart';

void main() {
  test('a brand-new item (zero lapses) is multiple choice', () {
    expect(exerciseFormatFor(lapses: 0), ExerciseFormat.multipleChoice);
  });

  test('an item lapsed at least once is typed', () {
    expect(exerciseFormatFor(lapses: 1), ExerciseFormat.typed);
    expect(exerciseFormatFor(lapses: 5), ExerciseFormat.typed);
  });
}
