import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../../domain/repositories/checkin_repository.dart';
import '../db/database.dart';

class DriftCheckInRepository implements CheckInRepository {
  DriftCheckInRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<bool, AppError>> checkIn(
    String languageCode,
    DateTime date,
  ) async {
    try {
      await _db.into(_db.checkIns).insertOnConflictUpdate(
            CheckInsCompanion.insert(
              languageCode: languageCode,
              date: _dateKey(date),
            ),
          );
      return const Result.ok(true);
    } catch (e) {
      return Result.err(
        StorageError('Failed to record check-in for "$languageCode": $e'),
      );
    }
  }

  @override
  Future<Result<List<DateTime>, AppError>> getCheckInDates(
    String languageCode,
  ) async {
    try {
      final rows = await (_db.select(_db.checkIns)
            ..where((t) => t.languageCode.equals(languageCode)))
          .get();
      return Result.ok([for (final row in rows) DateTime.parse(row.date)]);
    } catch (e) {
      return Result.err(
        StorageError('Failed to load check-ins for "$languageCode": $e'),
      );
    }
  }

  String _dateKey(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
