import 'package:drift/drift.dart';

import '../../../domain/entities/item_type.dart';
import 'units_table.dart';

/// Mirrors domain/entities/item.dart. `Item.id` is permanent — see that
/// entity's doc comment; never renumber rows, only edit their content.
@DataClassName('ItemRow')
class Items extends Table {
  TextColumn get id => text()();
  TextColumn get unitId => text().references(Units, #id)();
  TextColumn get type =>
      text().map(const EnumNameConverter<ItemType>(ItemType.values))();
  TextColumn get target => text()();
  TextColumn get native => text()();
  TextColumn get audioRef => text().nullable()();
  TextColumn get altSpelling => text().nullable()();
  TextColumn get furigana => text().nullable()();
  TextColumn get pinyin => text().nullable()();
  TextColumn get pitchAccent => text().nullable()();
  TextColumn get note => text().nullable()();

  /// Authored order within the unit; backs `Unit.itemIds`.
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
