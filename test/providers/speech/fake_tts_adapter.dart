import 'package:linguaforge/providers/speech/tts_adapter.dart';

/// Records calls instead of touching a platform channel — the real
/// [TtsAdapter] wraps flutter_tts, which has no plugin implementation in
/// the headless test environment.
class FakeTtsAdapter implements TtsAdapter {
  final List<({String text, String voiceHint})> spokenCalls = [];
  int stopCalls = 0;

  @override
  Future<void> speak(String text, {required String voiceHint}) async {
    spokenCalls.add((text: text, voiceHint: voiceHint));
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }
}
