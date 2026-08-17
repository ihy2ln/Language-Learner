import 'unit.dart';

/// A versioned, checksummed content bundle for one language
/// (CONTENT-AUTHORING.md). Published independently of app releases.
class ContentBundle {
  const ContentBundle({
    required this.languageCode,
    required this.schemaVersion,
    required this.contentVersion,
    required this.units,
    required this.checksum,
  });

  final String languageCode;
  final int schemaVersion;

  /// Bumps on any content change; the app diffs and updates without
  /// resetting progress.
  final String contentVersion;

  final List<Unit> units;
  final String checksum;
}
