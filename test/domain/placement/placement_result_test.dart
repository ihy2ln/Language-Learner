import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/placement/placement_result.dart';

void main() {
  test('a perfect score is banded confident', () {
    final result = computePlacementResult(correctCount: 12, totalCount: 12);

    expect(result.band, PlacementBand.confident);
    expect(result.scorePercent, closeTo(100, 1e-9));
  });

  test('a middling score is banded developing', () {
    final result = computePlacementResult(correctCount: 6, totalCount: 12);

    expect(result.band, PlacementBand.developing);
    expect(result.scorePercent, closeTo(50, 1e-9));
  });

  test('a low score is banded beginner', () {
    final result = computePlacementResult(correctCount: 1, totalCount: 12);

    expect(result.band, PlacementBand.beginner);
  });

  test('a zero-item session does not divide by zero', () {
    final result = computePlacementResult(correctCount: 0, totalCount: 0);

    expect(result.scorePercent, 0);
    expect(result.band, PlacementBand.beginner);
  });

  test('the 80 and 50 percent boundaries are inclusive on the higher band',
      () {
    expect(
      computePlacementResult(correctCount: 8, totalCount: 10).band,
      PlacementBand.confident,
    );
    expect(
      computePlacementResult(correctCount: 5, totalCount: 10).band,
      PlacementBand.developing,
    );
  });
}
