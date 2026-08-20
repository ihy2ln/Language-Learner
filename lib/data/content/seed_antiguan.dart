import '../../domain/entities/entities.dart';

/// Antiguan Creole — the language record only, no content.
///
/// CONTENT-AUTHORING.md is explicit that this is the longest-lead item in
/// the project and can't be shortened by writing code faster: it needs
/// paid native speakers (one lead author, a second reviewer) producing
/// 300-500 items in the frozen Cassidy-JLU orthography, plus a full
/// native recording pass. There is no placeholder vocabulary here — a
/// handful of invented or LLM-drafted Creole phrases would be exactly
/// the failure CLAUDE.md hard rule #4 exists to prevent, just committed
/// to the seed data instead of generated at runtime.
///
/// The language still appears in the picker, correctly labeled Tier 0
/// with every capability flag reflecting what genuinely has no provider
/// (CLAUDE.md hard rule #6) — "not yet available" is the honest state,
/// not a hidden row.
Language antiguanLanguage() {
  return const Language(
    code: 'aig',
    name: 'Antiguan Creole',
    nativeName: 'Antiguan Creole',
    tier: Tier.tier0Special,
    hasCuratedContent: false,
    hasTts: false,
    hasAsr: false,
    hasPronunciationScoring: false,
    llmCorpusConstrained: true,
    script: Script.latin,
    rtl: false,
  );
}
