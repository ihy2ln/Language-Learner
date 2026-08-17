import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/entities/user_progress.dart';
import 'package:linguaforge/domain/scheduler/scheduler.dart';

void main() {
  final now = DateTime.utc(2026, 1, 1);
  const scheduler = FsrsScheduler();

  group('retrievability', () {
    test('is 1.0 at zero elapsed time', () {
      expect(
        scheduler.retrievability(elapsedDays: 0, stability: 10),
        1.0,
      );
    });

    test('is 1.0 for any elapsed time when stability is zero or less', () {
      expect(scheduler.retrievability(elapsedDays: 5, stability: 0), 0.0);
      expect(scheduler.retrievability(elapsedDays: 5, stability: -1), 0.0);
    });

    test('equals ~0.9 when elapsed days equals stability (by definition)', () {
      for (final stability in [1.0, 5.0, 20.0, 100.0]) {
        final r = scheduler.retrievability(
          elapsedDays: stability,
          stability: stability,
        );
        expect(r, closeTo(0.9, 1e-9));
      }
    });

    test('decreases monotonically as elapsed time grows', () {
      final samples = [0.0, 1.0, 5.0, 10.0, 50.0, 200.0];
      double? previous;
      for (final t in samples) {
        final r = scheduler.retrievability(elapsedDays: t, stability: 15);
        if (previous != null) {
          expect(r, lessThanOrEqualTo(previous));
        }
        previous = r;
      }
    });
  });

  group('intervalDaysForStability', () {
    test('equals stability when requestRetention is exactly 0.9', () {
      const s =
          FsrsScheduler(parameters: FsrsParameters(requestRetention: 0.9));
      for (final stability in [1.0, 10.0, 60.0]) {
        expect(s.intervalDaysForStability(stability), closeTo(stability, 1e-6));
      }
    });

    test('a higher target retention yields a shorter interval', () {
      const relaxed = FsrsScheduler(
        parameters: FsrsParameters(requestRetention: 0.8),
      );
      const strict = FsrsScheduler(
        parameters: FsrsParameters(requestRetention: 0.97),
      );
      expect(
        strict.intervalDaysForStability(30),
        lessThan(relaxed.intervalDaysForStability(30)),
      );
    });

    test('is clamped to the configured minimum', () {
      const s = FsrsScheduler(
        parameters: FsrsParameters(minIntervalDays: 3),
      );
      expect(s.intervalDaysForStability(0.001), 3.0);
    });

    test('is clamped to the configured maximum', () {
      const s = FsrsScheduler(
        parameters: FsrsParameters(maximumIntervalDays: 30),
      );
      expect(s.intervalDaysForStability(1e9), 30.0);
    });

    test('increases as stability increases', () {
      final a = scheduler.intervalDaysForStability(5);
      final b = scheduler.intervalDaysForStability(50);
      expect(b, greaterThan(a));
    });
  });

  group('review() — first review of a new item', () {
    test('initializes stability from the weight vector by grade', () {
      for (final grade in Grade.values) {
        final progress = scheduler.review(
          itemId: 'i1',
          current: null,
          grade: grade,
          now: now,
        );
        expect(
          progress.stability,
          closeTo(FsrsParameters.defaultWeights[grade.value - 1], 1e-9),
        );
      }
    });

    test('sets reps to 1 and lastReview/dueAt from now', () {
      final progress = scheduler.review(
        itemId: 'i1',
        current: null,
        grade: Grade.good,
        now: now,
      );
      expect(progress.reps, 1);
      expect(progress.lastReview, now);
      expect(progress.dueAt.isAfter(now), isTrue);
    });

    test('counts an initial Again as a lapse', () {
      final again = scheduler.review(
        itemId: 'i1',
        current: null,
        grade: Grade.again,
        now: now,
      );
      final good = scheduler.review(
        itemId: 'i1',
        current: null,
        grade: Grade.good,
        now: now,
      );
      expect(again.lapses, 1);
      expect(good.lapses, 0);
    });

    test('difficulty is clamped to [1, 10]', () {
      for (final grade in Grade.values) {
        final progress = scheduler.review(
          itemId: 'i1',
          current: null,
          grade: grade,
          now: now,
        );
        expect(progress.difficulty, inInclusiveRange(1.0, 10.0));
      }
    });

    test('a first Easy grade schedules further out than a first Again', () {
      final easy = scheduler.review(
        itemId: 'i1',
        current: null,
        grade: Grade.easy,
        now: now,
      );
      final again = scheduler.review(
        itemId: 'i1',
        current: null,
        grade: Grade.again,
        now: now,
      );
      expect(easy.dueAt.isAfter(again.dueAt), isTrue);
    });
  });

  group('review() — subsequent reviews', () {
    UserProgress firstGood() => scheduler.review(
          itemId: 'i1',
          current: null,
          grade: Grade.good,
          now: now,
        );

    test('reps increments and lastReview advances', () {
      final first = firstGood();
      final reviewTime = first.dueAt;
      final second = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.good,
        now: reviewTime,
      );
      expect(second.reps, first.reps + 1);
      expect(second.lastReview, reviewTime);
    });

    test('a lapse (Again) increments lapses and does not increase stability',
        () {
      final first = firstGood();
      final lapsed = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.again,
        now: first.dueAt,
      );
      expect(lapsed.lapses, first.lapses + 1);
      expect(lapsed.stability, lessThanOrEqualTo(first.stability));
    });

    test(
        'reviewed on time (at the due date), Easy > Good > Hard in next stability',
        () {
      final first = firstGood();
      final onTime = first.dueAt;

      final afterHard = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.hard,
        now: onTime,
      );
      final afterGood = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.good,
        now: onTime,
      );
      final afterEasy = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.easy,
        now: onTime,
      );

      expect(afterHard.stability, lessThan(afterGood.stability));
      expect(afterGood.stability, lessThan(afterEasy.stability));
    });

    test('repeated on-time Good reviews grow stability across cycles', () {
      var progress = firstGood();
      final stabilities = <double>[progress.stability];
      for (var i = 0; i < 5; i++) {
        progress = scheduler.review(
          itemId: 'i1',
          current: progress,
          grade: Grade.good,
          now: progress.dueAt,
        );
        stabilities.add(progress.stability);
      }
      for (var i = 1; i < stabilities.length; i++) {
        expect(stabilities[i], greaterThan(stabilities[i - 1]));
      }
    });

    test(
        'reviewing early (high retrievability) grows stability less than '
        'reviewing exactly on time', () {
      final first = firstGood();
      final early = first.lastReview.add(const Duration(days: 1));
      final onTime = first.dueAt;

      final afterEarly = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.good,
        now: early,
      );
      final afterOnTime = scheduler.review(
        itemId: 'i1',
        current: first,
        grade: Grade.good,
        now: onTime,
      );

      expect(afterEarly.stability, lessThan(afterOnTime.stability));
    });

    test('difficulty stays within [1, 10] across many mixed reviews', () {
      var progress = firstGood();
      final grades = [
        Grade.again,
        Grade.hard,
        Grade.good,
        Grade.easy,
        Grade.again,
        Grade.good,
        Grade.good,
        Grade.easy,
      ];
      for (final grade in grades) {
        progress = scheduler.review(
          itemId: 'i1',
          current: progress,
          grade: grade,
          now: progress.dueAt,
        );
        expect(progress.difficulty, inInclusiveRange(1.0, 10.0));
      }
    });

    test('stability never drops to zero or below after a lapse', () {
      var progress = firstGood();
      for (var i = 0; i < 10; i++) {
        progress = scheduler.review(
          itemId: 'i1',
          current: progress,
          grade: Grade.again,
          now: progress.dueAt,
        );
        expect(progress.stability, greaterThan(0));
      }
    });
  });
}
