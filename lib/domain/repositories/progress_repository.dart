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

  /// Returns `Ok(true)` on success. `Result<void, ...>` doesn't work in
  /// Dart (`void` can't be used as a constructed value — `Ok<void, E>`
  /// won't typecheck against a `null` payload), so this uses `bool`
  /// instead of the `void` this originally shipped with.
  Future<Result<bool, AppError>> save(
    String languageCode,
    UserProgress progress,
  );
}
