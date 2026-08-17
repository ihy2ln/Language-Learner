import 'package:drift/drift.dart';

import 'grammar_notes_table.dart';
import 'items_table.dart';

/// Join table backing `GrammarNote.exampleItemIds` (an ordered list on the
/// domain entity).
@DataClassName('GrammarNoteExampleRow')
class GrammarNoteExamples extends Table {
  TextColumn get noteId => text().references(GrammarNotes, #id)();
  TextColumn get itemId => text().references(Items, #id)();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {noteId, itemId};
}
