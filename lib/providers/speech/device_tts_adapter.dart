import 'package:flutter_tts/flutter_tts.dart';

import 'tts_adapter.dart';

/// [TtsAdapter] backed by the platform's built-in text-to-speech engine via
/// the flutter_tts plugin. No network calls, no API key — voice quality and
/// language coverage depend entirely on what the OS ships.
class DeviceTtsAdapter implements TtsAdapter {
  DeviceTtsAdapter([FlutterTts? flutterTts])
    : _flutterTts = flutterTts ?? FlutterTts();

  final FlutterTts _flutterTts;

  String? _lastVoiceHint;

  @override
  Future<void> speak(String text, {required String voiceHint}) async {
    if (voiceHint != _lastVoiceHint) {
      await _flutterTts.setLanguage(voiceHint);
      _lastVoiceHint = voiceHint;
    }
    await _flutterTts.speak(text);
  }

  @override
  Future<void> stop() => _flutterTts.stop();
}
