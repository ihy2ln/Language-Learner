class GrammarNote {
  const GrammarNote({
    required this.id,
    required this.title,
    required this.body,
    this.exampleItemIds = const [],
  });

  final String id;
  final String title;
  final String body;

  /// Item ids illustrating this note.
  final List<String> exampleItemIds;
}
