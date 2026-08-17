import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/core/logging/logger.dart';
import 'package:linguaforge/core/logging/redacting_log_interceptor.dart';

import '../../providers/fakes/fake_http_client_adapter.dart';

class CapturingLogger implements Logger {
  final List<String> lines = [];

  @override
  void log(String message) => lines.add(message);
}

void main() {
  late FakeHttpClientAdapter fakeHttp;
  late CapturingLogger capturedLog;
  late Dio dio;

  const secretHeaderKey = 'sk-super-secret-do-not-leak';
  const secretQueryKey = 'AIza-super-secret-do-not-leak';

  setUp(() {
    fakeHttp = FakeHttpClientAdapter();
    capturedLog = CapturingLogger();
    dio = Dio()
      ..httpClientAdapter = fakeHttp
      ..interceptors.add(RedactingLogInterceptor(logger: capturedLog));
  });

  test(
      'a header-borne key never appears in the log, request, or response log lines',
      () async {
    fakeHttp.enqueue(const FakeResponse(statusCode: 200, body: {'ok': true}));

    await dio.get<void>(
      'https://api.example.com/models',
      options: Options(headers: {'Authorization': 'Bearer $secretHeaderKey'}),
    );

    final allLogText = capturedLog.lines.join('\n');
    expect(allLogText.contains(secretHeaderKey), isFalse);
    expect(allLogText.contains('REDACTED'), isTrue);

    // The interceptor must not have mutated the real outgoing request —
    // redaction is a logging concern only.
    expect(
      fakeHttp.requests.single.headers['Authorization'],
      'Bearer $secretHeaderKey',
    );
  });

  test('a query-param-borne key (Gemini-style) never appears in the log',
      () async {
    fakeHttp.enqueue(const FakeResponse(statusCode: 200, body: {'ok': true}));

    await dio.get<void>(
      'https://generativelanguage.googleapis.com/v1beta/models',
      queryParameters: {'key': secretQueryKey},
    );

    final allLogText = capturedLog.lines.join('\n');
    expect(allLogText.contains(secretQueryKey), isFalse);
    expect(allLogText.contains('REDACTED'), isTrue);

    expect(
      fakeHttp.requests.single.uri.queryParameters['key'],
      secretQueryKey,
    );
  });

  test('a key never appears in the log even on an error response', () async {
    fakeHttp.enqueue(const FakeResponse(
      statusCode: 401,
      body: {
        'error': {'message': 'Invalid API key'},
      },
    ));

    await dio.get<void>(
      'https://api.example.com/models',
      options: Options(
        headers: {'Authorization': 'Bearer $secretHeaderKey'},
        validateStatus: (_) => true,
      ),
    );

    final allLogText = capturedLog.lines.join('\n');
    expect(allLogText.contains(secretHeaderKey), isFalse);
  });

  test('non-key headers are logged untouched', () async {
    fakeHttp.enqueue(const FakeResponse(statusCode: 200, body: {'ok': true}));

    await dio.get<void>(
      'https://api.example.com/models',
      options: Options(headers: {'X-Request-Id': 'abc-123'}),
    );

    final allLogText = capturedLog.lines.join('\n');
    expect(allLogText.contains('abc-123'), isTrue);
  });
}
