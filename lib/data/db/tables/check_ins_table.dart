import 'package:drift/drift.dart';

import 'languages_table.dart';

/// One row per calendar day a learner opened and checked in on a language.
@DataClassName('CheckInRow')
class CheckIns extends Table {
  TextColumn get languageCode => text().references(Languages, #code)();

  /// 'YYYY-MM-DD' in the device's local calendar — a streak is a "did I
  /// show up today" concept, not a UTC instant, so this deliberately isn't
  /// a DateTimeColumn.
  TextColumn get date => text()();

  @override
  Set<Column> get primaryKey => {languageCode, date};
}
