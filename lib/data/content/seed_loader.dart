import 'package:drift/drift.dart';

import '../../domain/entities/entities.dart';
import '../db/database.dart';
import 'seed_antiguan.dart';
import 'seed_english_a1.dart';
import 'seed_japanese_a1.dart';
import 'seed_spanish_a1.dart';

/// Ensures every seeded language exists in [db]. Idempotent — safe to
/// call on every app start. Stands in for the real content-bundle
/// download pipeline (CONTENT-AUTHORING.md), which is out of scope here.
Future<void> ensureSeedContent(AppDatabase db) async {
  await _seedLanguageWithContent(
    db,
    language: spanishLanguage(),
    bundle: spanishA1GreetingsBundle(),
    unit: spanishA1GreetingsUnit(),
    items: spanishA1GreetingsItems,
  );
  await _seedLanguageWithContent(
    db,
    language: englishLanguage(),
    bundle: englishA1GreetingsBundle(),
    unit: englishA1GreetingsUnit(),
    items: englishA1GreetingsItems,
  );
  await _seedLanguageWithContent(
    db,
    language: japaneseLanguage(),
    bundle: japaneseA1GreetingsBundle(),
    unit: japaneseA1GreetingsUnit(),
    items: japaneseA1GreetingsItems,
  );
  // Antiguan Creole has no authored content yet — see seed_antiguan.dart.
  // Only the language record is seeded, no bundle/unit/items.
  await _upsertLanguage(db, antiguanLanguage());
}

Future<void> _upsertLanguage(AppDatabase db, Language language) async {
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
          ttsVoiceHint: Value(language.ttsVoiceHint),
        ),
      );
}

Future<void> _seedLanguageWithContent(
  AppDatabase db, {
  required Language language,
  required ContentBundle bundle,
  required Unit unit,
  required List<Item> items,
}) async {
  await _upsertLanguage(db, language);

  await db.into(db.contentBundles).insertOnConflictUpdate(
        ContentBundlesCompanion.insert(
          languageCode: bundle.languageCode,
          schemaVersion: bundle.schemaVersion,
          contentVersion: bundle.contentVersion,
          checksum: bundle.checksum,
        ),
      );

  await db.into(db.units).insertOnConflictUpdate(
        UnitsCompanion.insert(
          id: unit.id,
          languageCode: bundle.languageCode,
          title: unit.title,
          level: Value(unit.level),
          position: 0,
        ),
      );

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

    await (db.delete(db.itemTags)..where((t) => t.itemId.equals(item.id)))
        .go();
    if (item.tags.isNotEmpty) {
      await db.batch((batch) {
        batch.insertAll(db.itemTags, [
          for (final tag in item.tags)
            ItemTagsCompanion.insert(itemId: item.id, tag: tag),
        ]);
      });
    }

    await (db.delete(db.itemAcceptedAnswers)
          ..where((t) => t.itemId.equals(item.id)))
        .go();
    if (item.acceptedAnswers.isNotEmpty) {
      await db.batch((batch) {
        batch.insertAll(db.itemAcceptedAnswers, [
          for (final answer in item.acceptedAnswers)
            ItemAcceptedAnswersCompanion.insert(
              itemId: item.id,
              answer: answer,
            ),
        ]);
      });
    }
  }
}
