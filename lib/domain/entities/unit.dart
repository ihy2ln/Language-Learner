import 'cefr.dart';
import 'grammar_note.dart';

class Unit {
  const Unit({
    required this.id,
    required this.title,
    this.level,
    this.itemIds = const [],
    this.grammarNotes = const [],
  });

  final String id;
  final String title;

  /// `null` for Tier 0 content, which has no CEFR levels.
  final Cefr? level;

  final List<String> itemIds;
  final List<GrammarNote> grammarNotes;
}
