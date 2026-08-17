import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/providers/llm/llm_adapter.dart';
import 'package:linguaforge/providers/llm/openai_compatible_adapter.dart';
import 'package:linguaforge/providers/llm/provider_config.dart';

import '../fakes/fake_http_client_adapter.dart';

void main() {
  late FakeHttpClientAdapter fakeHttp;
  late Dio dio;

  setUp(() {
    fakeHttp = FakeHttpClientAdapter();
    dio = Dio()..httpClientAdapter = fakeHttp;
  });

  const config = OpenAiCompatibleProviderConfig(
    id: 'openrouter',
    displayName: 'OpenRouter',
    defaultBaseUrl: 'https://openrouter.ai/api/v1',
    keyFormatHint: 'sk-or-v1-…',
    requiresApiKey: true,
  );

  OpenAiCompatibleAdapter adapter() =>
      OpenAiCompatibleAdapter(config: config, dio: dio);

  group('validateKey', () {
    test(
        'cannot report success without hitting the network '
        '(no response queued)', () async {
      final result = await adapter().validateKey('sk-or-v1-whatever');

      // Nothing was queued on the fake adapter, so a Success here could
      // only mean the code path never actually consulted a network
      // response — which would be exactly the bug this project shipped
      // once before (a fake "key added" confirmation with no API call).
      expect(result, isA<KeyValidationFailure>());
      // But it still genuinely tried.
      expect(fakeHttp.requests, hasLength(1));
    });

    test('issues a real GET to {baseUrl}/models with the key in the header',
        () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'data': [
            {'id': 'gpt-4o'},
            {'id': 'gpt-4o-mini'},
          ],
        },
      ));

      final result = await adapter().validateKey('sk-or-v1-real-key-value');

      expect(fakeHttp.requests, hasLength(1));
      final request = fakeHttp.requests.single;
      expect(request.method, 'GET');
      expect(request.uri.toString(), 'https://openrouter.ai/api/v1/models');
      expect(
        request.headers['Authorization'],
        'Bearer sk-or-v1-real-key-value',
      );

      expect(result, isA<KeyValidationSuccess>());
      expect(
        (result as KeyValidationSuccess).availableModels,
        ['gpt-4o', 'gpt-4o-mini'],
      );
    });

    test('surfaces the provider\'s actual error text on a rejected key',
        () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 401,
        body: {
          'error': {'message': 'Invalid API key provided'},
        },
      ));

      final result = await adapter().validateKey('sk-or-v1-bad-key');

      expect(result, isA<KeyValidationFailure>());
      final failure = result as KeyValidationFailure;
      expect(failure.providerMessage, 'Invalid API key provided');
      expect(failure.statusCode, 401);
    });

    test('surfaces a description on a transport-level failure', () async {
      fakeHttp.enqueue(const FakeResponse(statusCode: 500, body: 'not json'));

      final result = await adapter().validateKey('sk-or-v1-key');

      expect(result, isA<KeyValidationFailure>());
    });

    test('a local provider sends no Authorization header at all', () async {
      const localConfig = OpenAiCompatibleProviderConfig(
        id: 'ollama',
        displayName: 'Ollama',
        defaultBaseUrl: 'http://localhost:11434/v1',
        keyFormatHint: 'none',
        requiresApiKey: false,
      );
      fakeHttp.enqueue(const FakeResponse(statusCode: 200, body: {'data': []}));

      final result = await OpenAiCompatibleAdapter(
        config: localConfig,
        dio: dio,
      ).validateKey('');

      expect(fakeHttp.requests.single.headers.containsKey('Authorization'),
          isFalse);
      expect(result, isA<KeyValidationSuccess>());
    });
  });

  group('complete', () {
    test('parses the chat completion content on success', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'choices': [
            {
              'message': {'role': 'assistant', 'content': 'Hola!'},
            },
          ],
        },
      ));

      final result = await adapter().complete(
        apiKey: 'sk-or-v1-key',
        model: 'gpt-4o-mini',
        messages: const [ChatMessage(role: 'user', content: 'Say hola')],
      );

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, 'Hola!');
    });

    test('returns an error result with the provider text on failure', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 429,
        body: {
          'error': {'message': 'Rate limit exceeded'},
        },
      ));

      final result = await adapter().complete(
        apiKey: 'sk-or-v1-key',
        model: 'gpt-4o-mini',
        messages: const [ChatMessage(role: 'user', content: 'hi')],
      );

      expect(result.isErr, isTrue);
      expect(result.errorOrNull?.message, 'Rate limit exceeded');
    });
  });
}
