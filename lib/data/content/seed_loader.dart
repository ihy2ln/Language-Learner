import 'package:drift/drift.dart';

import '../db/database.dart';
import 'seed_spanish_a1.dart';

/// Ensures the Spanish A1 greetings seed content exists in [db].
/// Idempotent — safe to call on every app start. Stands in for the real
/// content-bundle download pipeline (CONTENT-AUTHORING.md), which is out
/// of scope here.
Future<void> ensureSeedContent(AppDatabase db) async {
  final language = spanishLanguage();
  await db.into(db.languages).insertOnConflictUpdate(
        LanguagesCompanion.insert(
          code: language.code,
          name: language.name,
          nativeName: language.nativeName,
          tier: language.tier,
          script: language.script,
          hasCuratedContent: Value(language.hasCuratedContent),
          hasTts: Value(language.hasTts),
          hasAsr: Value(language.hasAsr),
          hasPronunciationScoring: Value(language.hasPronunciationScoring),
          llmCorpusConstrained: Value(language.llmCorpusConstrained),
          rtl: Value(language.rtl),
        ),
      );

  final bundle = spanishA1GreetingsBundle();
  await db.into(db.contentBundles).insertOnConflictUpdate(
        ContentBundlesCompanion.insert(
          languageCode: bundle.languageCode,
          schemaVersion: bundle.schemaVersion,
          contentVersion: bundle.contentVersion,
          checksum: bundle.checksum,
        ),
      );

  final unit = bundle.units.single;
  await db.into(db.units).insertOnConflictUpdate(
        UnitsCompanion.insert(
          id: unit.id,
          languageCode: bundle.languageCode,
          title: unit.title,
          level: Value(unit.level),
          position: 0,
        ),
      );

  final items = spanishA1GreetingsItems;
  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    await db.into(db.items).insertOnConflictUpdate(
          ItemsCompanion.insert(
            id: item.id,
            unitId: unit.id,
            type: item.type,
            target: item.target,
            native: item.native,
            position: i,
            audioRef: Value(item.audioRef),
            altSpelling: Value(item.altSpelling),
            furigana: Value(item.furigana),
            pinyin: Value(item.pinyin),
            pitchAccent: Value(item.pitchAccent),
            note: Value(item.note),
          ),
        );

    await (db.delete(db.itemTags)..where((t) => t.itemId.equals(item.id))).go();
    if (item.tags.isNotEmpty) {
      await db.batch((batch) {
        batch.insertAll(db.itemTags, [
          for (final tag in item.tags)
            ItemTagsCompanion.insert(itemId: item.id, tag: tag),
        ]);
      });
    }
  }
}
