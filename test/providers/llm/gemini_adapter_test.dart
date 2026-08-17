import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/providers/llm/gemini_adapter.dart';
import 'package:linguaforge/providers/llm/llm_adapter.dart';

import '../fakes/fake_http_client_adapter.dart';

void main() {
  late FakeHttpClientAdapter fakeHttp;
  late GeminiAdapter adapter;

  setUp(() {
    fakeHttp = FakeHttpClientAdapter();
    final dio = Dio()..httpClientAdapter = fakeHttp;
    adapter = GeminiAdapter(dio: dio);
  });

  group('validateKey', () {
    test('cannot report success without hitting the network', () async {
      final result = await adapter.validateKey('AIzaWhatever');

      expect(result, isA<KeyValidationFailure>());
      expect(fakeHttp.requests, hasLength(1));
    });

    test('sends the key as a query parameter, not a header', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'models': [
            {'name': 'models/gemini-2.5-flash'},
          ],
        },
      ));

      final result = await adapter.validateKey('AIzaRealKeyValue');

      final request = fakeHttp.requests.single;
      expect(request.uri.path, '/v1beta/models');
      expect(request.uri.queryParameters['key'], 'AIzaRealKeyValue');
      expect(request.headers.containsKey('Authorization'), isFalse);
      expect(request.headers.containsKey('x-api-key'), isFalse);

      expect(result, isA<KeyValidationSuccess>());
      expect(
        (result as KeyValidationSuccess).availableModels,
        ['models/gemini-2.5-flash'],
      );
    });

    test('surfaces Gemini\'s actual error text on a rejected key', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 400,
        body: {
          'error': {
            'code': 400,
            'message': 'API key not valid. Please pass a valid API key.',
            'status': 'INVALID_ARGUMENT',
          },
        },
      ));

      final result = await adapter.validateKey('bad-key');

      expect(result, isA<KeyValidationFailure>());
      expect(
        (result as KeyValidationFailure).providerMessage,
        'API key not valid. Please pass a valid API key.',
      );
    });
  });

  group('complete', () {
    test('parses candidates[0].content.parts[0].text on success', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'candidates': [
            {
              'content': {
                'parts': [
                  {'text': 'Hola, ¿cómo estás?'},
                ],
              },
            },
          ],
        },
      ));

      final result = await adapter.complete(
        apiKey: 'AIzaKey',
        model: 'gemini-2.5-flash',
        messages: const [ChatMessage(role: 'user', content: 'Greet me')],
      );

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, 'Hola, ¿cómo estás?');

      final request = fakeHttp.requests.single;
      expect(
          request.uri.path, '/v1beta/models/gemini-2.5-flash:generateContent');
      expect(request.uri.queryParameters['key'], 'AIzaKey');
    });
  });
}
