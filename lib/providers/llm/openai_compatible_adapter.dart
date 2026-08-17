import 'package:dio/dio.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import 'llm_adapter.dart';
import 'provider_config.dart';
import 'provider_json_utils.dart';

/// Shared adapter for every OpenAI-compatible provider (OpenRouter, OpenAI,
/// Grok, DeepSeek, GLM, Ollama, llama.cpp, LM Studio) — they differ only by
/// base URL, key, and model string (PROVIDERS.md). Adding a provider is a
/// [OpenAiCompatibleProviderConfig] entry, not a new class.
class OpenAiCompatibleAdapter implements LlmAdapter {
  OpenAiCompatibleAdapter({
    required this.config,
    required Dio dio,
    String? baseUrlOverride,
  })  : _dio = dio,
        baseUrl = baseUrlOverride ?? config.defaultBaseUrl;

  final OpenAiCompatibleProviderConfig config;
  final Dio _dio;
  final String baseUrl;

  @override
  String get providerId => config.id;

  @override
  String get displayName => config.displayName;

  @override
  bool get requiresApiKey => config.requiresApiKey;

  @override
  Future<KeyValidationResult> validateKey(String apiKey) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$baseUrl/models',
        options: Options(
          headers: requiresApiKey ? {'Authorization': 'Bearer $apiKey'} : null,
          validateStatus: (_) => true,
        ),
      );

      if (_isSuccessStatus(response.statusCode)) {
        return KeyValidationSuccess(
            availableModels: _parseModelIds(response.data));
      }
      return KeyValidationFailure(
        extractProviderErrorMessage(response.data) ??
            'HTTP ${response.statusCode}',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return KeyValidationFailure(describeDioError(e));
    }
  }

  @override
  Future<Result<String, AppError>> complete({
    required String apiKey,
    required String model,
    required List<ChatMessage> messages,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$baseUrl/chat/completions',
        options: Options(
          headers: requiresApiKey ? {'Authorization': 'Bearer $apiKey'} : null,
          validateStatus: (_) => true,
        ),
        data: {
          'model': model,
          'messages': [
            for (final m in messages) {'role': m.role, 'content': m.content},
          ],
        },
      );

      if (!_isSuccessStatus(response.statusCode)) {
        return Result.err(NetworkError(
          extractProviderErrorMessage(response.data) ??
              'HTTP ${response.statusCode}',
        ));
      }

      final content = _parseChatContent(response.data);
      if (content == null) {
        return Result.err(
          UnknownError('Unexpected response shape from $providerId'),
        );
      }
      return Result.ok(content);
    } on DioException catch (e) {
      return Result.err(NetworkError(describeDioError(e)));
    }
  }

  bool _isSuccessStatus(int? statusCode) =>
      statusCode != null && statusCode >= 200 && statusCode < 300;

  List<String> _parseModelIds(Map<String, dynamic>? data) {
    final list = data?['data'];
    if (list is! List) return const [];
    return [
      for (final entry in list)
        if (entry is Map && entry['id'] is String) entry['id'] as String,
    ];
  }

  String? _parseChatContent(Map<String, dynamic>? data) {
    final choices = data?['choices'];
    if (choices is! List || choices.isEmpty) return null;
    final first = choices.first;
    if (first is! Map) return null;
    final message = first['message'];
    if (message is! Map) return null;
    final content = message['content'];
    return content is String ? content : null;
  }
}
