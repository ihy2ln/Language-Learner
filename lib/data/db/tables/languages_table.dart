import 'package:drift/drift.dart';

import '../../../domain/entities/script.dart';
import '../../../domain/entities/tier.dart';

/// Mirrors domain/entities/language.dart.
@DataClassName('LanguageRow')
class Languages extends Table {
  /// BCP-47, e.g. "es-419", "ja", "aig".
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get nativeName => text()();
  TextColumn get tier =>
      text().map(const EnumNameConverter<Tier>(Tier.values))();
  BoolColumn get hasCuratedContent =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get hasTts => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAsr => boolean().withDefault(const Constant(false))();
  BoolColumn get hasPronunciationScoring =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get llmCorpusConstrained =>
      boolean().withDefault(const Constant(false))();
  TextColumn get script =>
      text().map(const EnumNameConverter<Script>(Script.values))();
  BoolColumn get rtl => boolean().withDefault(const Constant(false))();
  TextColumn get ttsVoiceHint => text().nullable()();

  @override
  Set<Column> get primaryKey => {code};
}
