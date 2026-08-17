import 'exercise_type.dart';

enum SessionEntryKind { dueReview, lapsedReview, newItem, conversation }

/// One slot in a composed review session.
class SessionEntry {
  const SessionEntry({
    required this.kind,
    required this.itemId,
    required this.availableExercises,
  });

  final SessionEntryKind kind;

  /// `null` only for [SessionEntryKind.conversation], which isn't tied to
  /// a single item.
  final String? itemId;

  /// Already filtered by CapabilityFilter — empty means this entry has
  /// no exercise the language/item currently supports and should be
  /// skipped by the UI rather than shown broken (CLAUDE.md hard rule #6).
  final Set<ExerciseType> availableExercises;
}
