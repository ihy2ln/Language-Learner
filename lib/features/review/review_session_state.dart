import '../../domain/entities/entities.dart';
import '../../domain/session/session.dart';

/// UI-facing state for one review session: which entries are queued and
/// which one is current.
class ReviewSessionState {
  const ReviewSessionState({
    required this.language,
    required this.itemsById,
    required this.entries,
    required this.lapsesByItemId,
    required this.currentIndex,
    required this.reviewedCount,
    required this.correctCount,
    required this.isPlacementTest,
  });

  final Language language;
  final Map<String, Item> itemsById;
  final List<SessionEntry> entries;

  /// Each item's lapse count as of session start (absent, i.e. 0, for an
  /// item with no prior progress) — read once at build time to decide
  /// each card's exercise format (domain/exercise); not updated
  /// mid-session.
  final Map<String, int> lapsesByItemId;

  final int currentIndex;
  final int reviewedCount;

  /// Graded Good — used for the placement-test score.
  final int correctCount;

  /// True when this session was built with no prior progress for the
  /// language at all, i.e. it's the learner's first-ever session — see
  /// ReviewSessionController.build for how this is detected.
  final bool isPlacementTest;

  bool get isFinished => currentIndex >= entries.length;

  SessionEntry? get currentEntry => isFinished ? null : entries[currentIndex];

  Item? get currentItem {
    final entry = currentEntry;
    if (entry?.itemId == null) return null;
    return itemsById[entry!.itemId];
  }

  int get currentLapses => lapsesByItemId[currentEntry?.itemId] ?? 0;

  ReviewSessionState copyWith({
    int? currentIndex,
    int? reviewedCount,
    int? correctCount,
  }) {
    return ReviewSessionState(
      language: language,
      itemsById: itemsById,
      entries: entries,
      lapsesByItemId: lapsesByItemId,
      currentIndex: currentIndex ?? this.currentIndex,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      correctCount: correctCount ?? this.correctCount,
      isPlacementTest: isPlacementTest,
    );
  }
}
