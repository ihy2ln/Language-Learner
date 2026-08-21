import 'package:drift/drift.dart';

import 'items_table.dart';

/// Join table backing `Item.acceptedAnswers` — other typed-answer
/// spellings/phrasings that count as correct for an item.
@DataClassName('ItemAcceptedAnswerRow')
class ItemAcceptedAnswers extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {itemId, answer};
}
