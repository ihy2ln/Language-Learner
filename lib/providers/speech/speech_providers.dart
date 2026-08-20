import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'device_tts_adapter.dart';
import 'tts_adapter.dart';

final ttsAdapterProvider = Provider<TtsAdapter>((ref) {
  return DeviceTtsAdapter();
});
