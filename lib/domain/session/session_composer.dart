import '../entities/item.dart';
import '../entities/language.dart';
import '../entities/unit.dart';
import '../entities/user_progress.dart';
import 'capability_filter.dart';
import 'exercise_type.dart';
import 'session_entry.dart';

/// Builds a review session in the order given by ARCHITECTURE.md §
/// Learning engine:
///
/// 1. Due reviews, oldest-due first, capped at [dailyReviewBudget]
/// 2. Lapsed items, reintroduced (also oldest-due first), sharing the same
///    budget as (1) rather than a separate one — the doc names one "daily
///    review budget", not two
/// 3. New items from the current unit, capped at [dailyNewItemBudget]
/// 4. Conversation practice, appended once, if a provider is configured
///    and the language allows free generation
///
/// "Lapsed items" (2) has no dedicated tracking field in [UserProgress] —
/// there is no persisted "last grade" or review state (see that entity's
/// doc comment) — so this reads it as "currently due items with at least
/// one lapse in their history", ordered after (and lower priority than)
/// due items with a clean history. That is an interpretation of an
/// underspecified rule, not a literal reading of the doc; flagged for the
/// author to confirm or correct.
class SessionComposer {
  const SessionComposer({
    this.dailyReviewBudget = 100,
    this.dailyNewItemBudget = 20,
    this.capabilityFilter = const CapabilityFilter(),
  });

  final int dailyReviewBudget;
  final int dailyNewItemBudget;
  final CapabilityFilter capabilityFilter;

  List<SessionEntry> compose({
    required Language language,
    required Unit currentUnit,
    required Map<String, Item> itemsById,
    required List<UserProgress> progress,
    required DateTime now,
    required bool conversationProviderConfigured,
  }) {
    final progressByItemId = {for (final p in progress) p.itemId: p};

    final dueClean = progress
        .where((p) => !p.dueAt.isAfter(now) && p.lapses == 0)
        .toList()
      ..sort((a, b) => a.dueAt.compareTo(b.dueAt));
    final dueLapsed = progress
        .where((p) => !p.dueAt.isAfter(now) && p.lapses > 0)
        .toList()
      ..sort((a, b) => a.dueAt.compareTo(b.dueAt));

    final reviewEntries = <SessionEntry>[];
    void addReview(UserProgress p, SessionEntryKind kind) {
      if (reviewEntries.length >= dailyReviewBudget) return;
      final item = itemsById[p.itemId];
      if (item == null) return;
      reviewEntries.add(SessionEntry(
        kind: kind,
        itemId: p.itemId,
        availableExercises: capabilityFilter.availableFor(item, language),
      ));
    }

    for (final p in dueClean) {
      addReview(p, SessionEntryKind.dueReview);
    }
    for (final p in dueLapsed) {
      addReview(p, SessionEntryKind.lapsedReview);
    }

    final newEntries = <SessionEntry>[];
    for (final itemId in currentUnit.itemIds) {
      if (newEntries.length >= dailyNewItemBudget) break;
      if (progressByItemId.containsKey(itemId)) continue;
      final item = itemsById[itemId];
      if (item == null) continue;
      newEntries.add(SessionEntry(
        kind: SessionEntryKind.newItem,
        itemId: itemId,
        availableExercises: capabilityFilter.availableFor(item, language),
      ));
    }

    final entries = [...reviewEntries, ...newEntries];

    if (capabilityFilter.freeConversationAvailable(
      language,
      providerConfigured: conversationProviderConfigured,
    )) {
      entries.add(const SessionEntry(
        kind: SessionEntryKind.conversation,
        itemId: null,
        availableExercises: {ExerciseType.freeConversation},
      ));
    }

    return entries;
  }
}
