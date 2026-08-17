import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/providers/llm/anthropic_adapter.dart';
import 'package:linguaforge/providers/llm/llm_adapter.dart';

import '../fakes/fake_http_client_adapter.dart';

void main() {
  late FakeHttpClientAdapter fakeHttp;
  late AnthropicAdapter adapter;

  setUp(() {
    fakeHttp = FakeHttpClientAdapter();
    final dio = Dio()..httpClientAdapter = fakeHttp;
    adapter = AnthropicAdapter(dio: dio);
  });

  group('validateKey', () {
    test('cannot report success without hitting the network', () async {
      final result = await adapter.validateKey('sk-ant-whatever');

      expect(result, isA<KeyValidationFailure>());
      expect(fakeHttp.requests, hasLength(1));
    });

    test('sends x-api-key and anthropic-version headers, not Authorization',
        () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'data': [
            {'id': 'claude-sonnet-4-5'},
          ],
        },
      ));

      final result = await adapter.validateKey('sk-ant-real-key');

      final request = fakeHttp.requests.single;
      expect(request.uri.toString(), 'https://api.anthropic.com/v1/models');
      expect(request.headers['x-api-key'], 'sk-ant-real-key');
      expect(request.headers['anthropic-version'], '2023-06-01');
      expect(request.headers.containsKey('Authorization'), isFalse);

      expect(result, isA<KeyValidationSuccess>());
      expect(
        (result as KeyValidationSuccess).availableModels,
        ['claude-sonnet-4-5'],
      );
    });

    test('surfaces Anthropic\'s actual error text on a rejected key', () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 401,
        body: {
          'type': 'error',
          'error': {
            'type': 'authentication_error',
            'message': 'invalid x-api-key',
          },
        },
      ));

      final result = await adapter.validateKey('sk-ant-bad-key');

      expect(result, isA<KeyValidationFailure>());
      expect((result as KeyValidationFailure).providerMessage,
          'invalid x-api-key');
    });
  });

  group('complete', () {
    test('separates system messages from the message list, parses content',
        () async {
      fakeHttp.enqueue(const FakeResponse(
        statusCode: 200,
        body: {
          'content': [
            {'type': 'text', 'text': 'Buenos días!'},
          ],
        },
      ));

      final result = await adapter.complete(
        apiKey: 'sk-ant-key',
        model: 'claude-sonnet-4-5',
        messages: const [
          ChatMessage(role: 'system', content: 'You are a Spanish tutor.'),
          ChatMessage(role: 'user', content: 'Greet me'),
        ],
      );

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, 'Buenos días!');

      final body = fakeHttp.requests.single.data as Map;
      expect(body['system'], 'You are a Spanish tutor.');
      expect((body['messages'] as List).length, 1);
      expect((body['messages'] as List).single, {
        'role': 'user',
        'content': 'Greet me',
      });
    });
  });
}
