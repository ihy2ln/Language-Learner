import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../entities/user_progress.dart';

/// Abstract read/write access to [UserProgress] records for a language.
abstract interface class ProgressRepository {
  Future<Result<List<UserProgress>, AppError>> getAllForLanguage(
    String languageCode,
  );
  Future<Result<UserProgress?, AppError>> getForItem(
    String languageCode,
    String itemId,
  );
  Future<Result<void, AppError>> save(
    String languageCode,
    UserProgress progress,
  );
}
