import 'package:dio/dio.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import 'llm_adapter.dart';
import 'provider_json_utils.dart';

/// Native Anthropic Messages API. One of the two bespoke adapters
/// permitted by PROVIDERS.md — everything else goes through
/// [OpenAiCompatibleAdapter].
class AnthropicAdapter implements LlmAdapter {
  AnthropicAdapter({
    required Dio dio,
    this.baseUrl = 'https://api.anthropic.com/v1',
    this.apiVersion = '2023-06-01',
  }) : _dio = dio;

  final Dio _dio;
  final String baseUrl;
  final String apiVersion;

  @override
  String get providerId => 'anthropic';

  @override
  String get displayName => 'Anthropic';

  @override
  bool get requiresApiKey => true;

  Map<String, String> _headers(String apiKey) => {
        'x-api-key': apiKey,
        'anthropic-version': apiVersion,
      };

  @override
  Future<KeyValidationResult> validateKey(String apiKey) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$baseUrl/models',
        options:
            Options(headers: _headers(apiKey), validateStatus: (_) => true),
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
      // The Messages API separates the system prompt from conversation
      // turns, unlike the OpenAI-style "system" role in the message list.
      final systemText = messages
          .where((m) => m.role == 'system')
          .map((m) => m.content)
          .join('\n\n');
      final turns = messages.where((m) => m.role != 'system');

      final response = await _dio.post<Map<String, dynamic>>(
        '$baseUrl/messages',
        options:
            Options(headers: _headers(apiKey), validateStatus: (_) => true),
        data: {
          'model': model,
          'max_tokens': 1024,
          if (systemText.isNotEmpty) 'system': systemText,
          'messages': [
            for (final m in turns) {'role': m.role, 'content': m.content},
          ],
        },
      );

      if (!_isSuccessStatus(response.statusCode)) {
        return Result.err(NetworkError(
          extractProviderErrorMessage(response.data) ??
              'HTTP ${response.statusCode}',
        ));
      }

      final content = _parseContent(response.data);
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

  String? _parseContent(Map<String, dynamic>? data) {
    final content = data?['content'];
    if (content is! List || content.isEmpty) return null;
    final first = content.first;
    if (first is! Map) return null;
    final text = first['text'];
    return text is String ? text : null;
  }
}
