import 'package:drift/drift.dart';

/// Metadata for the currently-installed content bundle of one language.
/// Mirrors domain/entities/content_bundle.dart; the bundle's units/items
/// live in their own tables rather than nested here, so they stay
/// queryable. One row per language — the app tracks only the currently
/// installed `contentVersion`, per BUILD.md's delta-download model.
@DataClassName('ContentBundleRow')
class ContentBundles extends Table {
  TextColumn get languageCode => text()();
  IntColumn get schemaVersion => integer()();
  TextColumn get contentVersion => text()();
  TextColumn get checksum => text()();

  @override
  Set<Column> get primaryKey => {languageCode};
}
