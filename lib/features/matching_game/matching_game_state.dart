import '../../domain/entities/entities.dart';

/// One tile on the matching board — either an item's target-language word
/// or its native gloss. Two tiles share an [itemId]; a pair is matched
/// when both have been tapped in sequence.
class MatchTile {
  const MatchTile({
    required this.id,
    required this.text,
    required this.itemId,
    required this.isTarget,
  });

  final String id;
  final String text;
  final String itemId;
  final bool isTarget;
}

/// State for one matching round: tap a target word, then its meaning (or
/// vice versa). No FSRS grading, no progress writes.
class MatchingGameState {
  const MatchingGameState({
    required this.language,
    required this.tiles,
    required this.matchedItemIds,
    required this.selectedTileId,
    required this.mismatchTileIds,
    required this.mistakes,
  });

  final Language language;
  final List<MatchTile> tiles;
  final Set<String> matchedItemIds;
  final String? selectedTileId;

  /// The two tiles from the most recent wrong guess, shown briefly so the
  /// learner sees what didn't match before the board resets. Cleared
  /// explicitly (MatchingGameController.clearMismatchHighlight) rather
  /// than on a timer inside the controller, so the flash duration is a UI
  /// concern, not a state-management one.
  final (String, String)? mismatchTileIds;

  final int mistakes;

  bool get isFinished => matchedItemIds.length * 2 == tiles.length;
}
