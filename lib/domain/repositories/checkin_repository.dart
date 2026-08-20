import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';

/// Records and reads the days a learner checked in on a language.
abstract interface class CheckInRepository {
  /// Idempotent — checking in twice on the same calendar day is a no-op,
  /// not a duplicate row or an error.
  Future<Result<bool, AppError>> checkIn(String languageCode, DateTime date);

  /// All calendar days checked in for [languageCode], in no particular
  /// order. Callers needing a streak should pass this to [currentStreak].
  Future<Result<List<DateTime>, AppError>> getCheckInDates(
    String languageCode,
  );
}
