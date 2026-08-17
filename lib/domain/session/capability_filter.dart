import '../entities/item.dart';
import '../entities/item_type.dart';
import '../entities/language.dart';
import 'exercise_type.dart';

/// The single mechanism by which language tiers become visible in the
/// product (ARCHITECTURE.md): maps each [Item] to the exercise types its
/// content type can support in principle, then removes any the language
/// (or the item itself) doesn't actually have the capability for.
///
/// `Item.type` (what the content *is*) and `ExerciseType` (how it's
/// *practiced*) are two different taxonomies that ARCHITECTURE.md never
/// maps to each other explicitly — this function is that mapping.
class CapabilityFilter {
  const CapabilityFilter();

  /// Exercise types [item]'s content type can support, before any
  /// capability check.
  Set<ExerciseType> candidatesFor(Item item) {
    switch (item.type) {
      case ItemType.vocab:
        return const {ExerciseType.recognition, ExerciseType.recall};
      case ItemType.sentence:
        return const {
          ExerciseType.recognition,
          ExerciseType.recall,
          ExerciseType.cloze,
        };
      case ItemType.grammarPoint:
        return const {ExerciseType.recognition, ExerciseType.recall};
      case ItemType.listening:
        return const {ExerciseType.listening};
      case ItemType.pronunciation:
        return const {
          ExerciseType.speakingUnscored,
          ExerciseType.speakingScored,
        };
    }
  }

  /// [candidatesFor] narrowed to what [language] (and [item] itself, for
  /// pre-recorded audio) actually supports. Never assumes from
  /// [Language.tier] directly — always reads the capability flags
  /// (CLAUDE.md hard rule #6).
  Set<ExerciseType> availableFor(Item item, Language language) {
    return candidatesFor(item)
        .where((type) => _isSupported(type, item, language))
        .toSet();
  }

  bool _isSupported(ExerciseType type, Item item, Language language) {
    switch (type) {
      case ExerciseType.recognition:
      case ExerciseType.recall:
        return true;
      case ExerciseType.cloze:
        return language.hasCuratedContent;
      case ExerciseType.listening:
        return language.hasTts || item.audioRef != null;
      case ExerciseType.speakingUnscored:
        return language.hasAsr;
      case ExerciseType.speakingScored:
        return language.hasAsr && language.hasPronunciationScoring;
      case ExerciseType.freeConversation:
        // Not item-driven; see SessionComposer for how this is offered.
        return false;
    }
  }

  /// Whether free conversation practice may be offered at all for
  /// [language], given a provider is configured. Corpus-constrained
  /// languages (Antiguan Creole) never get free-form generation
  /// (CLAUDE.md hard rule #4) — only template-driven practice, which is
  /// out of scope for this filter.
  bool freeConversationAvailable(
    Language language, {
    required bool providerConfigured,
  }) {
    return providerConfigured && !language.llmCorpusConstrained;
  }
}
