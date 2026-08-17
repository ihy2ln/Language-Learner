/// Language support tier. Stored as data on [Language] and read at
/// session-build time — never assumed in code (CLAUDE.md hard rule #6).
enum Tier {
  /// Antiguan Creole. Human-authored, natively recorded, no TTS/ASR,
  /// LLM output corpus-constrained.
  tier0Special,

  /// English, Spanish, Japanese: curated A1-B2, TTS, pronunciation scoring,
  /// LLM conversation.
  tier1Full,

  /// ~35 major languages: TTS, pronunciation scoring, LLM-assisted content.
  tier2Audio,

  /// Long tail: text-only LLM practice, labelled experimental.
  tier3TextOnly,
}
