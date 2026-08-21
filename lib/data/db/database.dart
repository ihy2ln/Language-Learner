import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/cefr.dart';
import '../../domain/entities/item_type.dart';
import '../../domain/entities/script.dart';
import '../../domain/entities/tier.dart';
import 'tables/check_ins_table.dart';
import 'tables/content_bundles_table.dart';
import 'tables/grammar_note_examples_table.dart';
import 'tables/grammar_notes_table.dart';
import 'tables/item_accepted_answers_table.dart';
import 'tables/item_tags_table.dart';
import 'tables/items_table.dart';
import 'tables/languages_table.dart';
import 'tables/units_table.dart';
import 'tables/user_progress_table.dart';

part 'database.g.dart';

/// Local SQLite database — the source of truth for offline-first storage
/// (ARCHITECTURE.md § Offline strategy). Schema only; DAOs and concrete
/// repository implementations are added when a feature needs them.
@DriftDatabase(tables: [
  Languages,
  ContentBundles,
  Units,
  GrammarNotes,
  GrammarNoteExamples,
  Items,
  ItemTags,
  UserProgressTable,
  CheckIns,
  ItemAcceptedAnswers,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(checkIns);
          }
          if (from < 3) {
            await m.createTable(itemAcceptedAnswers);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'linguaforge.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
