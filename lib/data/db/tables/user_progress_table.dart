import 'package:drift/drift.dart';

import 'items_table.dart';
import 'languages_table.dart';

/// Mirrors domain/entities/user_progress.dart. A single local learner —
/// there's no account/multi-profile concept, so this is keyed by item
/// alone. `languageCode` is denormalized from `Items.unitId ->
/// Units.languageCode` purely so "all progress for language X" doesn't
/// need a join on every read.
@DataClassName('UserProgressRow')
class UserProgressTable extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get languageCode => text().references(Languages, #code)();
  RealColumn get stability => real()();
  RealColumn get difficulty => real()();
  DateTimeColumn get lastReview => dateTime()();
  DateTimeColumn get dueAt => dateTime()();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {itemId};
}
