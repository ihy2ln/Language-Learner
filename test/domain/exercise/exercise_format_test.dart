import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/exercise/exercise_format.dart';

void main() {
  test('a brand-new item with no difficulty defaults to multiple choice', () {
    expect(exerciseFormatFor(null), ExerciseFormat.multipleChoice);
  });

  test('easy and medium difficulty are multiple choice', () {
    expect(exerciseFormatFor(1), ExerciseFormat.multipleChoice);
    expect(exerciseFormatFor(5), ExerciseFormat.multipleChoice);
  });

  test('hard and very hard difficulty are typed', () {
    expect(exerciseFormatFor(6), ExerciseFormat.typed);
    expect(exerciseFormatFor(10), ExerciseFormat.typed);
  });
}
