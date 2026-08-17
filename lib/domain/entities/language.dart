import 'script.dart';
import 'tier.dart';

/// A supported language and its capability flags.
///
/// Capability is data, not assumption (CLAUDE.md hard rule #6): the exercise
/// pool is filtered from these flags at session-build time, never from
/// [tier] alone.
class Language {
  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.tier,
    required this.hasCuratedContent,
    required this.hasTts,
    required this.hasAsr,
    required this.hasPronunciationScoring,
    required this.llmCorpusConstrained,
    required this.script,
    required this.rtl,
    this.ttsVoiceHint,
  });

  /// BCP-47, e.g. "es-419", "ja", "aig" (Antiguan Creole).
  final String code;
  final String name;
  final String nativeName;
  final Tier tier;
  final bool hasCuratedContent;
  final bool hasTts;
  final bool hasAsr;
  final bool hasPronunciationScoring;

  /// True for Antiguan Creole. The LLM may quiz, explain, or recombine
  /// corpus content but must never generate novel text in this language
  /// (CLAUDE.md hard rule #4).
  final bool llmCorpusConstrained;

  final Script script;
  final bool rtl;
  final String? ttsVoiceHint;
}
