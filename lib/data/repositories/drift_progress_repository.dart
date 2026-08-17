import 'package:drift/drift.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../db/database.dart';

class DriftProgressRepository implements ProgressRepository {
  DriftProgressRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<UserProgress>, AppError>> getAllForLanguage(
    String languageCode,
  ) async {
    try {
      final rows = await (_db.select(_db.userProgressTable)
            ..where((t) => t.languageCode.equals(languageCode)))
          .get();
      return Result.ok(rows.map(_toDomain).toList());
    } catch (e) {
      return Result.err(StorageError('Failed to load progress: $e'));
    }
  }

  @override
  Future<Result<UserProgress?, AppError>> getForItem(
    String languageCode,
    String itemId,
  ) async {
    try {
      final row = await (_db.select(_db.userProgressTable)
            ..where((t) => t.itemId.equals(itemId)))
          .getSingleOrNull();
      return Result.ok(row == null ? null : _toDomain(row));
    } catch (e) {
      return Result.err(
        StorageError('Failed to load progress for "$itemId": $e'),
      );
    }
  }

  @override
  Future<Result<bool, AppError>> save(
    String languageCode,
    UserProgress progress,
  ) async {
    try {
      await _db.into(_db.userProgressTable).insertOnConflictUpdate(
            UserProgressTableCompanion(
              itemId: Value(progress.itemId),
              languageCode: Value(languageCode),
              stability: Value(progress.stability),
              difficulty: Value(progress.difficulty),
              lastReview: Value(progress.lastReview),
              dueAt: Value(progress.dueAt),
              lapses: Value(progress.lapses),
              reps: Value(progress.reps),
            ),
          );
      return const Result.ok(true);
    } catch (e) {
      return Result.err(
        StorageError('Failed to save progress for "${progress.itemId}": $e'),
      );
    }
  }

  UserProgress _toDomain(UserProgressRow row) => UserProgress(
        itemId: row.itemId,
        stability: row.stability,
        difficulty: row.difficulty,
        lastReview: row.lastReview,
        dueAt: row.dueAt,
        lapses: row.lapses,
        reps: row.reps,
      );
}
