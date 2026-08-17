import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/core/errors/app_error.dart';
import 'package:linguaforge/core/errors/result.dart';
import 'package:linguaforge/providers/llm/llm_adapter.dart';
import 'package:linguaforge/providers/routing/llm_task.dart';
import 'package:linguaforge/providers/routing/model_routing_config.dart';
import 'package:linguaforge/providers/routing/task_router.dart';

class _FakeAdapter implements LlmAdapter {
  _FakeAdapter({
    required this.providerId,
    this.result,
  }) : requiresApiKey = true;

  @override
  final String providerId;

  @override
  String get displayName => providerId;

  @override
  final bool requiresApiKey;

  final Result<String, AppError>? result;
  int completeCallCount = 0;

  @override
  Future<KeyValidationResult> validateKey(String apiKey) async {
    throw UnimplementedError('not exercised by TaskRouter tests');
  }

  @override
  Future<Result<String, AppError>> complete({
    required String apiKey,
    required String model,
    required List<ChatMessage> messages,
  }) async {
    completeCallCount++;
    return result ?? const Result.err(NetworkError('no result configured'));
  }
}

void main() {
  const routingJson = '''
  {
    "tasks": {
      "conversationPractice": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      },
      "grammarExplanation": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      },
      "sentenceGeneration": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      },
      "errorCorrection": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      },
      "translationCheck": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      },
      "offline": {
        "default": {"provider": "primary", "model": "primary-model"},
        "fallback": {"provider": "backup", "model": "backup-model"}
      }
    }
  }
  ''';

  test('uses the default route when it succeeds, never touching the fallback',
      () async {
    final primary = _FakeAdapter(
      providerId: 'primary',
      result: const Result.ok('primary response'),
    );
    final backup = _FakeAdapter(providerId: 'backup');

    final router = TaskRouter(
      config: ModelRoutingConfig.fromJsonString(routingJson),
      adapters: {'primary': primary, 'backup': backup},
      apiKeyFor: (_) async => 'a-key',
    );

    final result = await router.complete(
      task: LlmTask.conversationPractice,
      messages: const [ChatMessage(role: 'user', content: 'hi')],
    );

    expect(result.valueOrNull, 'primary response');
    expect(primary.completeCallCount, 1);
    expect(backup.completeCallCount, 0);
  });

  test('falls through to the fallback route when the default fails', () async {
    final primary = _FakeAdapter(
      providerId: 'primary',
      result: const Result.err(NetworkError('primary is down')),
    );
    final backup = _FakeAdapter(
      providerId: 'backup',
      result: const Result.ok('backup response'),
    );

    final router = TaskRouter(
      config: ModelRoutingConfig.fromJsonString(routingJson),
      adapters: {'primary': primary, 'backup': backup},
      apiKeyFor: (_) async => 'a-key',
    );

    final result = await router.complete(
      task: LlmTask.conversationPractice,
      messages: const [ChatMessage(role: 'user', content: 'hi')],
    );

    expect(result.valueOrNull, 'backup response');
    expect(primary.completeCallCount, 1);
    expect(backup.completeCallCount, 1);
  });

  test('returns the fallback\'s error when both routes fail', () async {
    final primary = _FakeAdapter(
      providerId: 'primary',
      result: const Result.err(NetworkError('primary is down')),
    );
    final backup = _FakeAdapter(
      providerId: 'backup',
      result: const Result.err(NetworkError('backup is down too')),
    );

    final router = TaskRouter(
      config: ModelRoutingConfig.fromJsonString(routingJson),
      adapters: {'primary': primary, 'backup': backup},
      apiKeyFor: (_) async => 'a-key',
    );

    final result = await router.complete(
      task: LlmTask.conversationPractice,
      messages: const [ChatMessage(role: 'user', content: 'hi')],
    );

    expect(result.isErr, isTrue);
    expect(result.errorOrNull?.message, 'backup is down too');
  });

  test('fails closed when no key is configured for a provider that needs one',
      () async {
    final primary = _FakeAdapter(providerId: 'primary');
    final backup = _FakeAdapter(providerId: 'backup');

    final router = TaskRouter(
      config: ModelRoutingConfig.fromJsonString(routingJson),
      adapters: {'primary': primary, 'backup': backup},
      apiKeyFor: (_) async => null,
    );

    final result = await router.complete(
      task: LlmTask.conversationPractice,
      messages: const [ChatMessage(role: 'user', content: 'hi')],
    );

    expect(result.isErr, isTrue);
    expect(primary.completeCallCount, 0);
    expect(backup.completeCallCount, 0);
  });
}
