import 'package:drift/drift.dart';

import '../../../domain/entities/cefr.dart';
import 'content_bundles_table.dart';

/// Mirrors domain/entities/unit.dart. `Unit.itemIds` isn't stored as a
/// list column — it's derived from `Items.unitId` ordered by
/// `Items.position` (see items_table.dart).
@DataClassName('UnitRow')
class Units extends Table {
  TextColumn get id => text()();
  TextColumn get languageCode =>
      text().references(ContentBundles, #languageCode)();
  TextColumn get title => text()();

  /// `null` for Tier 0 content, which has no CEFR levels.
  TextColumn get level => text().nullable().map(cefrConverter)();

  /// Authored order within the bundle.
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

const cefrConverter =
    NullAwareTypeConverter<Cefr, String>.wrap(EnumNameConverter(Cefr.values));
