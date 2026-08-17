import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/providers/routing/llm_task.dart';
import 'package:linguaforge/providers/routing/model_routing_config.dart';

void main() {
  test('parses a default/fallback route for every LlmTask', () {
    const json = '''
    {
      "tasks": {
        "conversationPractice": {
          "default": {"provider": "gemini", "model": "gemini-2.5-flash"},
          "fallback": {"provider": "openai", "model": "gpt-4o-mini"}
        },
        "grammarExplanation": {
          "default": {"provider": "anthropic", "model": "claude-sonnet-4-5"},
          "fallback": {"provider": "gemini", "model": "gemini-2.5-pro"}
        },
        "sentenceGeneration": {
          "default": {"provider": "gemini", "model": "gemini-2.5-flash"},
          "fallback": {"provider": "deepseek", "model": "deepseek-chat"}
        },
        "errorCorrection": {
          "default": {"provider": "anthropic", "model": "claude-sonnet-4-5"},
          "fallback": {"provider": "openai", "model": "gpt-4o"}
        },
        "translationCheck": {
          "default": {"provider": "deepseek", "model": "deepseek-chat"},
          "fallback": {"provider": "glm", "model": "glm-4.5"}
        },
        "offline": {
          "default": {"provider": "ollama", "model": "qwen3:4b"},
          "fallback": {"provider": "ollama", "model": "gemma3:4b"}
        }
      }
    }
    ''';

    final config = ModelRoutingConfig.fromJsonString(json);

    for (final task in LlmTask.values) {
      final route = config.routeFor(task);
      expect(route.defaultRoute.providerId, isNotEmpty);
      expect(route.defaultRoute.model, isNotEmpty);
      expect(route.fallbackRoute.providerId, isNotEmpty);
      expect(route.fallbackRoute.model, isNotEmpty);
    }

    expect(
        config.routeFor(LlmTask.conversationPractice).defaultRoute.providerId,
        'gemini');
    expect(
      config.routeFor(LlmTask.grammarExplanation).defaultRoute.providerId,
      'anthropic',
    );
  });

  test('throws for a task missing from the config', () {
    final config = ModelRoutingConfig.fromJsonString('{"tasks": {}}');
    expect(
      () => config.routeFor(LlmTask.offline),
      throwsA(isA<StateError>()),
    );
  });

  test(
      'the bundled assets/config/model_routing.json parses and covers every task',
      () {
    final jsonString =
        File('assets/config/model_routing.json').readAsStringSync();
    // Sanity-check it's valid JSON before parsing through the config type.
    jsonDecode(jsonString);

    final config = ModelRoutingConfig.fromJsonString(jsonString);
    for (final task in LlmTask.values) {
      expect(() => config.routeFor(task), returnsNormally);
    }
  });
}
