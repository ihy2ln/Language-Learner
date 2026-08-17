import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'llm_task.dart';

class ModelRoute {
  const ModelRoute({required this.providerId, required this.model});

  final String providerId;
  final String model;

  factory ModelRoute.fromJson(Map<String, dynamic> json) {
    return ModelRoute(
      providerId: json['provider'] as String,
      model: json['model'] as String,
    );
  }
}

class TaskRoute {
  const TaskRoute({required this.defaultRoute, required this.fallbackRoute});

  final ModelRoute defaultRoute;
  final ModelRoute fallbackRoute;

  factory TaskRoute.fromJson(Map<String, dynamic> json) {
    return TaskRoute(
      defaultRoute:
          ModelRoute.fromJson(json['default'] as Map<String, dynamic>),
      fallbackRoute:
          ModelRoute.fromJson(json['fallback'] as Map<String, dynamic>),
    );
  }
}

/// Task -> {default, fallback} model routing, loaded from
/// `assets/config/model_routing.json` rather than hardcoded in Dart —
/// PROVIDERS.md: "Model identifiers live in configuration rather than
/// code — they change frequently and should not require a release."
///
/// The identifiers shipped in that file are a reasonable starting point
/// matching PROVIDERS.md's routing table, not verified current-as-of-today
/// model names — update the JSON as providers change their lineup; no
/// code change needed. Same caveat as FsrsParameters' default weights:
/// provisional, not a value to trust blindly.
class ModelRoutingConfig {
  const ModelRoutingConfig(this._routes);

  final Map<LlmTask, TaskRoute> _routes;

  TaskRoute routeFor(LlmTask task) {
    final route = _routes[task];
    if (route == null) {
      throw StateError('No routing configured for task ${task.name}');
    }
    return route;
  }

  factory ModelRoutingConfig.fromJsonString(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    final tasksJson = decoded['tasks'] as Map<String, dynamic>;
    final routes = <LlmTask, TaskRoute>{};
    for (final task in LlmTask.values) {
      final taskJson = tasksJson[task.name];
      if (taskJson is Map<String, dynamic>) {
        routes[task] = TaskRoute.fromJson(taskJson);
      }
    }
    return ModelRoutingConfig(routes);
  }

  static Future<ModelRoutingConfig> loadFromAssets({
    String assetPath = 'assets/config/model_routing.json',
  }) async {
    final jsonString = await rootBundle.loadString(assetPath);
    return ModelRoutingConfig.fromJsonString(jsonString);
  }
}
