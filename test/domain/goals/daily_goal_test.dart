import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/goals/daily_goal.dart';

void main() {
  test('nothing done yet is an all-incomplete checklist', () {
    final goals = computeDailyGoals(
      checkedInToday: false,
      itemsReviewedToday: 0,
    );

    expect(goals, hasLength(2));
    expect(goals.every((g) => !g.isComplete), isTrue);
  });

  test('check-in goal completes independently of review activity', () {
    final goals = computeDailyGoals(
      checkedInToday: true,
      itemsReviewedToday: 0,
    );

    expect(goals[0].isComplete, isTrue);
    expect(goals[1].isComplete, isFalse);
  });

  test('review goal completes once the count meets the target', () {
    final belowTarget = computeDailyGoals(
      checkedInToday: false,
      itemsReviewedToday: 4,
      reviewGoalCount: 5,
    );
    final atTarget = computeDailyGoals(
      checkedInToday: false,
      itemsReviewedToday: 5,
      reviewGoalCount: 5,
    );

    expect(belowTarget[1].isComplete, isFalse);
    expect(atTarget[1].isComplete, isTrue);
  });
}
