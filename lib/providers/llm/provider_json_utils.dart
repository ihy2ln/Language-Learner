import 'package:dio/dio.dart';

/// Extracts a human-readable error message from a JSON error body shaped
/// like `{"error": {"message": "..."}}` or `{"error": "..."}` — the
/// convention OpenAI, Anthropic, and Gemini all use (nested vs. flat).
/// Falls back to the raw body so nothing is ever silently swallowed.
String? extractProviderErrorMessage(dynamic data) {
  if (data is Map) {
    final error = data['error'];
    if (error is Map && error['message'] is String) {
      return error['message'] as String;
    }
    if (error is String) return error;
  }
  if (data == null) return null;
  return data.toString();
}

/// Describes a [DioException] for surfacing to the user — CLAUDE.md hard
/// rule #1 requires the actual error text, not a canned "invalid key".
String describeDioError(DioException e) {
  final response = e.response;
  if (response != null) {
    final message = extractProviderErrorMessage(response.data);
    if (message != null) return message;
    return 'HTTP ${response.statusCode}';
  }
  return e.message ?? e.toString();
}
