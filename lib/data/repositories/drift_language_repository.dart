import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../../domain/entities/language.dart';
import '../../domain/repositories/language_repository.dart';
import '../db/database.dart';

class DriftLanguageRepository implements LanguageRepository {
  DriftLanguageRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<List<Language>, AppError>> getAll() async {
    try {
      final rows = await _db.select(_db.languages).get();
      return Result.ok(rows.map(_toDomain).toList());
    } catch (e) {
      return Result.err(StorageError('Failed to load languages: $e'));
    }
  }

  @override
  Future<Result<Language, AppError>> getByCode(String code) async {
    try {
      final row = await (_db.select(_db.languages)
            ..where((t) => t.code.equals(code)))
          .getSingleOrNull();
      if (row == null) {
        return Result.err(NotFoundError('Language "$code" not found'));
      }
      return Result.ok(_toDomain(row));
    } catch (e) {
      return Result.err(StorageError('Failed to load language "$code": $e'));
    }
  }

  Language _toDomain(LanguageRow row) => Language(
        code: row.code,
        name: row.name,
        nativeName: row.nativeName,
        tier: row.tier,
        hasCuratedContent: row.hasCuratedContent,
        hasTts: row.hasTts,
        hasAsr: row.hasAsr,
        hasPronunciationScoring: row.hasPronunciationScoring,
        llmCorpusConstrained: row.llmCorpusConstrained,
        script: row.script,
        rtl: row.rtl,
        ttsVoiceHint: row.ttsVoiceHint,
      );
}
