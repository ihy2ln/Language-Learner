import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/redacting_log_interceptor.dart';
import '../../core/storage/secure_storage_provider.dart';
import 'anthropic_adapter.dart';
import 'gemini_adapter.dart';
import 'llm_adapter.dart';
import 'openai_compatible_adapter.dart';
import 'provider_config.dart';
import 'provider_key_store.dart';

/// Shared Dio instance for every LLM adapter, with key redaction attached
/// unconditionally — there is no code path that constructs an
/// LLM-provider-facing Dio without it.
final llmDioProvider = Provider<Dio>((ref) {
  return Dio()..interceptors.add(RedactingLogInterceptor());
});

/// Every configured adapter, keyed by provider id — the OpenAI-compatible
/// row in PROVIDERS.md's table plus the two bespoke ones.
final llmAdaptersProvider = Provider<Map<String, LlmAdapter>>((ref) {
  final dio = ref.watch(llmDioProvider);
  return {
    for (final config in openAiCompatibleProviders)
      config.id: OpenAiCompatibleAdapter(config: config, dio: dio),
    'anthropic': AnthropicAdapter(dio: dio),
    'gemini': GeminiAdapter(dio: dio),
  };
});

final providerKeyStoreProvider = Provider<ProviderKeyStore>((ref) {
  return ProviderKeyStore(ref.watch(secureStorageProvider));
});
