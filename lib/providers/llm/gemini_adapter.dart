import 'package:dio/dio.dart';

import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import 'llm_adapter.dart';
import 'provider_json_utils.dart';

/// Native Google Gemini API. One of the two bespoke adapters permitted by
/// PROVIDERS.md — everything else goes through [OpenAiCompatibleAdapter].
/// The key travels as a `key` query parameter rather than a header, which
/// is exactly the kind of provider quirk that makes header-only log
/// redaction insufficient — see core/logging's redacting interceptor.
class GeminiAdapter implements LlmAdapter {
  GeminiAdapter({
    required Dio dio,
    this.baseUrl = 'https://generativelanguage.googleapis.com/v1beta',
  }) : _dio = dio;

  final Dio _dio;
  final String baseUrl;

  @override
  String get providerId => 'gemini';

  @override
  String get displayName => 'Google Gemini';

  @override
  bool get requiresApiKey => true;

  @override
  Future<KeyValidationResult> validateKey(String apiKey) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$baseUrl/models',
        queryParameters: {'key': apiKey},
        options: Options(validateStatus: (_) => true),
      );

      if (_isSuccessStatus(response.statusCode)) {
        return KeyValidationSuccess(
            availableModels: _parseModelNames(response.data));
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
        '$baseUrl/models/$model:generateContent',
        queryParameters: {'key': apiKey},
        options: Options(validateStatus: (_) => true),
        data: {
          'contents': [
            for (final m in messages.where((m) => m.role != 'system'))
              {
                'role': m.role == 'assistant' ? 'model' : 'user',
                'parts': [
                  {'text': m.content},
                ],
              },
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

  List<String> _parseModelNames(Map<String, dynamic>? data) {
    final list = data?['models'];
    if (list is! List) return const [];
    return [
      for (final entry in list)
        if (entry is Map && entry['name'] is String) entry['name'] as String,
    ];
  }

  String? _parseContent(Map<String, dynamic>? data) {
    final candidates = data?['candidates'];
    if (candidates is! List || candidates.isEmpty) return null;
    final first = candidates.first;
    if (first is! Map) return null;
    final content = first['content'];
    if (content is! Map) return null;
    final parts = content['parts'];
    if (parts is! List || parts.isEmpty) return null;
    final firstPart = parts.first;
    if (firstPart is! Map) return null;
    final text = firstPart['text'];
    return text is String ? text : null;
  }
}
