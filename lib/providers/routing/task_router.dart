import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../llm/llm_adapter.dart';
import 'llm_task.dart';
import 'model_routing_config.dart';

/// Resolves a [LlmTask] to a provider/model via [ModelRoutingConfig], then
/// executes it: try the default route, and only on failure fall through to
/// the fallback route — PROVIDERS.md: "Task-based routing with the
/// fallback chain from the routing table."
class TaskRouter {
  TaskRouter({
    required this.config,
    required Map<String, LlmAdapter> adapters,
    required this.apiKeyFor,
  }) : _adapters = adapters;

  final ModelRoutingConfig config;
  final Map<String, LlmAdapter> _adapters;

  /// Looks up the stored key for a provider id. Returns `null`/empty for
  /// providers that don't need one (local providers) or aren't configured.
  final Future<String?> Function(String providerId) apiKeyFor;

  Future<Result<String, AppError>> complete({
    required LlmTask task,
    required List<ChatMessage> messages,
  }) async {
    final route = config.routeFor(task);

    final defaultResult = await _tryRoute(route.defaultRoute, messages);
    if (defaultResult.isOk) return defaultResult;

    return _tryRoute(route.fallbackRoute, messages);
  }

  Future<Result<String, AppError>> _tryRoute(
    ModelRoute route,
    List<ChatMessage> messages,
  ) async {
    final adapter = _adapters[route.providerId];
    if (adapter == null) {
      return Result.err(
        UnknownError(
            'No adapter registered for provider "${route.providerId}"'),
      );
    }

    var apiKey = '';
    if (adapter.requiresApiKey) {
      final storedKey = await apiKeyFor(route.providerId);
      if (storedKey == null || storedKey.isEmpty) {
        return Result.err(
          ValidationError('No API key configured for "${route.providerId}"'),
        );
      }
      apiKey = storedKey;
    }

    return adapter.complete(
      apiKey: apiKey,
      model: route.model,
      messages: messages,
    );
  }
}
