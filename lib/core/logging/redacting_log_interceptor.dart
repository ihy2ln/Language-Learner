import 'package:dio/dio.dart';

import 'logger.dart';

/// Dio interceptor that logs requests/responses with API keys stripped
/// first — CLAUDE.md hard rule #2 ("Redact keys in all logging") and
/// PROVIDERS.md § Key management point 3 ("Redaction in logging is
/// mandatory. The Dio interceptor strips key headers before anything is
/// written").
///
/// Keys travel two ways across the adapters in this project: as a header
/// (`Authorization: Bearer ...` for OpenAI-compatible providers,
/// `x-api-key` for Anthropic) or as a query parameter (`?key=...` for
/// Gemini). Both are redacted — a header-only implementation would leak
/// every Gemini key into the log.
class RedactingLogInterceptor extends Interceptor {
  RedactingLogInterceptor({
    Logger? logger,
    this.redactedHeaderNames = const {'authorization', 'x-api-key'},
    this.redactedQueryParamNames = const {'key'},
  }) : _logger = logger ?? const PrintLogger();

  final Logger _logger;
  final Set<String> redactedHeaderNames;
  final Set<String> redactedQueryParamNames;

  // No brackets: this also gets embedded in a query string via Uri.replace
  // when redacting a query-param-borne key, and '[' / ']' would come back
  // percent-encoded there — still safe, just not the literal string a
  // naive log-scanning test (or human) would search for.
  static const _mask = 'REDACTED';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _logger.log('--> ${options.method} ${_redactUri(options.uri)}');
    _logger.log('    headers: ${_redactHeaders(options.headers)}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.log(
      '<-- ${response.statusCode} ${_redactUri(response.requestOptions.uri)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.log(
      '<-- ERROR ${err.response?.statusCode} '
      '${_redactUri(err.requestOptions.uri)}: ${err.message}',
    );
    handler.next(err);
  }

  Uri _redactUri(Uri uri) {
    if (uri.queryParameters.isEmpty) return uri;
    final redacted = {
      for (final entry in uri.queryParameters.entries)
        entry.key: redactedQueryParamNames.contains(entry.key.toLowerCase())
            ? _mask
            : entry.value,
    };
    return uri.replace(queryParameters: redacted);
  }

  Map<String, dynamic> _redactHeaders(Map<String, dynamic> headers) {
    return {
      for (final entry in headers.entries)
        entry.key: redactedHeaderNames.contains(entry.key.toLowerCase())
            ? _mask
            : entry.value,
    };
  }
}
