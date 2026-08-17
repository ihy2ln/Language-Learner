/// A way of practicing an item, per the capability table in
/// ARCHITECTURE.md § Learning engine.
enum ExerciseType {
  /// Target -> native. Requires nothing.
  recognition,

  /// Native -> target. Requires nothing.
  recall,

  /// Requires curated sentence content.
  cloze,

  /// Requires audio (TTS or recorded).
  listening,

  /// Requires a microphone.
  speakingUnscored,

  /// Requires Azure pronunciation assessment + a supported locale.
  speakingScored,

  /// Requires an LLM provider configured. Never offered for
  /// corpus-constrained languages — see [Language.llmCorpusConstrained].
  freeConversation,
}
