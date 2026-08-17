import 'package:drift/drift.dart';

import 'units_table.dart';

/// Mirrors domain/entities/grammar_note.dart.
@DataClassName('GrammarNoteRow')
class GrammarNotes extends Table {
  TextColumn get id => text()();
  TextColumn get unitId => text().references(Units, #id)();
  TextColumn get title => text()();
  TextColumn get body => text()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
