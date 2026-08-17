import 'package:drift/drift.dart';

import 'items_table.dart';

/// Join table backing `Item.tags` (e.g. jlpt-n5, register-formal,
/// dialect-latam).
@DataClassName('ItemTagRow')
class ItemTags extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get tag => text()();

  @override
  Set<Column> get primaryKey => {itemId, tag};
}
