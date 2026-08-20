import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/checkin/streak.dart';

void main() {
  final today = DateTime(2026, 8, 20);

  test('no check-ins is a zero streak', () {
    expect(currentStreak([], asOf: today), 0);
  });

  test('checked in today only is a streak of one', () {
    expect(currentStreak([today], asOf: today), 1);
  });

  test('consecutive days ending today count all of them', () {
    final dates = [
      today,
      today.subtract(const Duration(days: 1)),
      today.subtract(const Duration(days: 2)),
    ];
    expect(currentStreak(dates, asOf: today), 3);
  });

  test('not checked in today but checked in yesterday keeps the streak alive', () {
    final dates = [
      today.subtract(const Duration(days: 1)),
      today.subtract(const Duration(days: 2)),
    ];
    expect(currentStreak(dates, asOf: today), 2);
  });

  test('a gap before yesterday breaks the streak at zero', () {
    final dates = [today.subtract(const Duration(days: 3))];
    expect(currentStreak(dates, asOf: today), 0);
  });

  test('a gap in the middle stops counting past the gap', () {
    final dates = [
      today,
      today.subtract(const Duration(days: 1)),
      // gap at day 2
      today.subtract(const Duration(days: 3)),
    ];
    expect(currentStreak(dates, asOf: today), 2);
  });

  test('ignores time-of-day when comparing calendar days', () {
    final dates = [
      DateTime(2026, 8, 20, 23, 59),
      DateTime(2026, 8, 19, 0, 1),
    ];
    expect(currentStreak(dates, asOf: DateTime(2026, 8, 20, 6)), 2);
  });
}
