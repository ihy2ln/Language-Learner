import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../entities/language.dart';

/// Abstract read access to installed [Language] records.
///
/// Implemented in `data/repositories/` against the Drift database.
/// `domain/` depends on nothing below it — see ARCHITECTURE.md.
abstract interface class LanguageRepository {
  Future<Result<List<Language>, AppError>> getAll();
  Future<Result<Language, AppError>> getByCode(String code);
}
