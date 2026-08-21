import 'package:drift/drift.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../../domain/entities/content_bundle.dart';
import '../../domain/entities/grammar_note.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/unit.dart';
import '../../domain/repositories/content_repository.dart';
import '../db/database.dart';

class DriftContentRepository implements ContentRepository {
  DriftContentRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<ContentBundle, AppError>> getBundle(
    String languageCode,
  ) async {
    try {
      final bundleRow = await (_db.select(_db.contentBundles)
            ..where((t) => t.languageCode.equals(languageCode)))
          .getSingleOrNull();
      if (bundleRow == null) {
        return Result.err(
          NotFoundError('No content bundle for "$languageCode"'),
        );
      }

      final unitRows = await (_db.select(_db.units)
            ..where((t) => t.languageCode.equals(languageCode))
            ..orderBy([(t) => OrderingTerm(expression: t.position)]))
          .get();
      final units = <Unit>[
        for (final row in unitRows) await _toDomainUnit(row),
      ];

      return Result.ok(ContentBundle(
        languageCode: bundleRow.languageCode,
        schemaVersion: bundleRow.schemaVersion,
        contentVersion: bundleRow.contentVersion,
        units: units,
        checksum: bundleRow.checksum,
      ));
    } catch (e) {
      return Result.err(StorageError('Failed to load content bundle: $e'));
    }
  }

  @override
  Future<Result<Unit, AppError>> getUnit(
    String languageCode,
    String unitId,
  ) async {
    try {
      final row = await (_db.select(_db.units)
            ..where(
              (t) => t.id.equals(unitId) & t.languageCode.equals(languageCode),
            ))
          .getSingleOrNull();
      if (row == null) {
        return Result.err(NotFoundError('Unit "$unitId" not found'));
      }
      return Result.ok(await _toDomainUnit(row));
    } catch (e) {
      return Result.err(StorageError('Failed to load unit "$unitId": $e'));
    }
  }

  @override
  Future<Result<Item, AppError>> getItem(
    String languageCode,
    String itemId,
  ) async {
    try {
      final row = await (_db.select(_db.items)
            ..where((t) => t.id.equals(itemId)))
          .getSingleOrNull();
      if (row == null) {
        return Result.err(NotFoundError('Item "$itemId" not found'));
      }
      return Result.ok(await _toDomainItem(row));
    } catch (e) {
      return Result.err(StorageError('Failed to load item "$itemId": $e'));
    }
  }

  Future<Unit> _toDomainUnit(UnitRow row) async {
    final itemRows = await (_db.select(_db.items)
          ..where((t) => t.unitId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .get();
    final noteRows = await (_db.select(_db.grammarNotes)
          ..where((t) => t.unitId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .get();
    final notes = <GrammarNote>[
      for (final noteRow in noteRows) await _toDomainGrammarNote(noteRow),
    ];

    return Unit(
      id: row.id,
      title: row.title,
      level: row.level,
      itemIds: [for (final itemRow in itemRows) itemRow.id],
      grammarNotes: notes,
    );
  }

  Future<GrammarNote> _toDomainGrammarNote(GrammarNoteRow row) async {
    final exampleRows = await (_db.select(_db.grammarNoteExamples)
          ..where((t) => t.noteId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.position)]))
        .get();
    return GrammarNote(
      id: row.id,
      title: row.title,
      body: row.body,
      exampleItemIds: [for (final example in exampleRows) example.itemId],
    );
  }

  Future<Item> _toDomainItem(ItemRow row) async {
    final tagRows = await (_db.select(_db.itemTags)
          ..where((t) => t.itemId.equals(row.id)))
        .get();
    final acceptedAnswerRows = await (_db.select(_db.itemAcceptedAnswers)
          ..where((t) => t.itemId.equals(row.id)))
        .get();
    return Item(
      id: row.id,
      type: row.type,
      target: row.target,
      native: row.native,
      audioRef: row.audioRef,
      altSpelling: row.altSpelling,
      furigana: row.furigana,
      pinyin: row.pinyin,
      pitchAccent: row.pitchAccent,
      tags: [for (final tagRow in tagRows) tagRow.tag],
      note: row.note,
      acceptedAnswers: [for (final a in acceptedAnswerRows) a.answer],
    );
  }
}
