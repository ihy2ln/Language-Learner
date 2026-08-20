/// Speaks a word or phrase aloud on demand.
///
/// This is a thin capability boundary, not an LLM provider adapter — there's
/// no key validation or routing here, just "say this text in this voice."
/// Callers must gate on [Language.hasTts] before ever calling [speak]
/// (CLAUDE.md hard rule #6: capability is read from data). A language with
/// `hasTts: false` has no adapter call site at all, not a silently-ignored
/// one.
abstract interface class TtsAdapter {
  /// Speaks [text] using the voice identified by [voiceHint] (a BCP-47 tag,
  /// e.g. "es-MX", "ja-JP" — see [Language.ttsVoiceHint]). Completes when
  /// playback finishes; does not report success/failure the way a network
  /// call would, since this is a local platform capability rather than
  /// something that can be rejected by a remote provider.
  Future<void> speak(String text, {required String voiceHint});

  /// Stops any in-progress speech immediately.
  Future<void> stop();
}
