import '../../domain/entities/entities.dart';
import '../../domain/session/session.dart';

/// UI-facing state for one review session: which entries are queued, which
/// one is current, and whether its answer is currently revealed.
class ReviewSessionState {
  const ReviewSessionState({
    required this.language,
    required this.itemsById,
    required this.entries,
    required this.currentIndex,
    required this.revealed,
    required this.reviewedCount,
    required this.correctCount,
    required this.isPlacementTest,
  });

  final Language language;
  final Map<String, Item> itemsById;
  final List<SessionEntry> entries;
  final int currentIndex;
  final bool revealed;
  final int reviewedCount;

  /// Graded Good or Easy — used for the placement-test score.
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

  ReviewSessionState copyWith({
    int? currentIndex,
    bool? revealed,
    int? reviewedCount,
    int? correctCount,
  }) {
    return ReviewSessionState(
      language: language,
      itemsById: itemsById,
      entries: entries,
      currentIndex: currentIndex ?? this.currentIndex,
      revealed: revealed ?? this.revealed,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      correctCount: correctCount ?? this.correctCount,
      isPlacementTest: isPlacementTest,
    );
  }
}
