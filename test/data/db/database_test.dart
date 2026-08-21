import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/domain/entities/entities.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('round-trips a language row, including enum columns', () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'es-419',
            name: 'Spanish',
            nativeName: 'Español',
            tier: Tier.tier1Full,
            script: Script.latin,
            hasCuratedContent: const Value(true),
          ),
        );

    final row = await (db.select(db.languages)
          ..where((t) => t.code.equals('es-419')))
        .getSingle();

    expect(row.tier, Tier.tier1Full);
    expect(row.script, Script.latin);
    expect(row.hasCuratedContent, isTrue);
    expect(row.hasTts, isFalse);
  });

  test('unit.level round-trips null for Tier 0 content', () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'aig',
            name: 'Antiguan Creole',
            nativeName: 'Antiguan Creole',
            tier: Tier.tier0Special,
            script: Script.latin,
          ),
        );
    await db.into(db.contentBundles).insert(
          ContentBundlesCompanion.insert(
            languageCode: 'aig',
            schemaVersion: 1,
            contentVersion: '2026.01',
            checksum: 'abc',
          ),
        );
    await db.into(db.units).insert(
          UnitsCompanion.insert(
            id: 'aig-greetings',
            languageCode: 'aig',
            title: 'Greetings',
            position: 0,
          ),
        );

    final unit = await (db.select(db.units)
          ..where((t) => t.id.equals('aig-greetings')))
        .getSingle();

    expect(unit.level, isNull);
  });

  test('an item and its tags round-trip through the join table', () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'es-419',
            name: 'Spanish',
            nativeName: 'Español',
            tier: Tier.tier1Full,
            script: Script.latin,
          ),
        );
    await db.into(db.contentBundles).insert(
          ContentBundlesCompanion.insert(
            languageCode: 'es-419',
            schemaVersion: 1,
            contentVersion: '2026.01',
            checksum: 'abc',
          ),
        );
    await db.into(db.units).insert(
          UnitsCompanion.insert(
            id: 'es-a1-01',
            languageCode: 'es-419',
            title: 'Greetings',
            position: 0,
          ),
        );
    await db.into(db.items).insert(
          ItemsCompanion.insert(
            id: 'es-a1-01-i001',
            unitId: 'es-a1-01',
            type: ItemType.vocab,
            target: 'buenos días',
            native: 'good morning',
            position: 0,
          ),
        );
    await db.batch((batch) {
      batch.insertAll(db.itemTags, [
        const ItemTagsCompanion(
          itemId: Value('es-a1-01-i001'),
          tag: Value('register-neutral'),
        ),
        const ItemTagsCompanion(
          itemId: Value('es-a1-01-i001'),
          tag: Value('dialect-universal'),
        ),
      ]);
    });

    final tags = await (db.select(db.itemTags)
          ..where((t) => t.itemId.equals('es-a1-01-i001')))
        .get();

    expect(tags.map((t) => t.tag).toSet(),
        {'register-neutral', 'dialect-universal'});
  });

  test('an item\'s accepted answers round-trip through the join table',
      () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'es-419',
            name: 'Spanish',
            nativeName: 'Español',
            tier: Tier.tier1Full,
            script: Script.latin,
          ),
        );
    await db.into(db.contentBundles).insert(
          ContentBundlesCompanion.insert(
            languageCode: 'es-419',
            schemaVersion: 1,
            contentVersion: '2026.01',
            checksum: 'abc',
          ),
        );
    await db.into(db.units).insert(
          UnitsCompanion.insert(
            id: 'es-a1-01',
            languageCode: 'es-419',
            title: 'Greetings',
            position: 0,
          ),
        );
    await db.into(db.items).insert(
          ItemsCompanion.insert(
            id: 'es-a1-01-i004',
            unitId: 'es-a1-01',
            type: ItemType.vocab,
            target: 'hola',
            native: 'hi',
            position: 0,
          ),
        );
    await db.batch((batch) {
      batch.insertAll(db.itemAcceptedAnswers, [
        const ItemAcceptedAnswersCompanion(
          itemId: Value('es-a1-01-i004'),
          answer: Value('hi'),
        ),
        const ItemAcceptedAnswersCompanion(
          itemId: Value('es-a1-01-i004'),
          answer: Value('hello'),
        ),
      ]);
    });

    final answers = await (db.select(db.itemAcceptedAnswers)
          ..where((t) => t.itemId.equals('es-a1-01-i004')))
        .get();

    expect(answers.map((a) => a.answer).toSet(), {'hi', 'hello'});
  });

  test('user progress round-trips FSRS fields with real timestamps', () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'es-419',
            name: 'Spanish',
            nativeName: 'Español',
            tier: Tier.tier1Full,
            script: Script.latin,
          ),
        );
    await db.into(db.contentBundles).insert(
          ContentBundlesCompanion.insert(
            languageCode: 'es-419',
            schemaVersion: 1,
            contentVersion: '2026.01',
            checksum: 'abc',
          ),
        );
    await db.into(db.units).insert(
          UnitsCompanion.insert(
            id: 'es-a1-01',
            languageCode: 'es-419',
            title: 'Greetings',
            position: 0,
          ),
        );
    await db.into(db.items).insert(
          ItemsCompanion.insert(
            id: 'es-a1-01-i001',
            unitId: 'es-a1-01',
            type: ItemType.vocab,
            target: 'buenos días',
            native: 'good morning',
            position: 0,
          ),
        );

    final lastReview = DateTime.utc(2026, 1, 1);
    final dueAt = DateTime.utc(2026, 1, 5);
    await db.into(db.userProgressTable).insert(
          UserProgressTableCompanion.insert(
            itemId: 'es-a1-01-i001',
            languageCode: 'es-419',
            stability: 4.2,
            difficulty: 5.7,
            lastReview: lastReview,
            dueAt: dueAt,
            lapses: const Value(1),
            reps: const Value(3),
          ),
        );

    final progress = await (db.select(db.userProgressTable)
          ..where((t) => t.itemId.equals('es-a1-01-i001')))
        .getSingle();

    expect(progress.stability, closeTo(4.2, 1e-9));
    expect(progress.difficulty, closeTo(5.7, 1e-9));
    // Drift's DateTimeColumn round-trips the instant but not necessarily
    // the UTC flag, so compare moments rather than DateTime.==.
    expect(progress.lastReview.isAtSameMomentAs(lastReview), isTrue);
    expect(progress.dueAt.isAtSameMomentAs(dueAt), isTrue);
    expect(progress.lapses, 1);
    expect(progress.reps, 3);
  });

  test('check-ins round-trip and upsert idempotently per calendar day',
      () async {
    await db.into(db.languages).insert(
          LanguagesCompanion.insert(
            code: 'es-419',
            name: 'Spanish',
            nativeName: 'Español',
            tier: Tier.tier1Full,
            script: Script.latin,
          ),
        );

    await db.into(db.checkIns).insertOnConflictUpdate(
          CheckInsCompanion.insert(languageCode: 'es-419', date: '2026-08-20'),
        );
    // Checking in again on the same day must not create a second row.
    await db.into(db.checkIns).insertOnConflictUpdate(
          CheckInsCompanion.insert(languageCode: 'es-419', date: '2026-08-20'),
        );
    await db.into(db.checkIns).insertOnConflictUpdate(
          CheckInsCompanion.insert(languageCode: 'es-419', date: '2026-08-19'),
        );

    final rows = await (db.select(db.checkIns)
          ..where((t) => t.languageCode.equals('es-419')))
        .get();

    expect(rows.map((r) => r.date).toSet(), {'2026-08-20', '2026-08-19'});
  });
}
