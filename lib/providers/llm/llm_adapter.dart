import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';

/// Outcome of [LlmAdapter.validateKey].
///
/// Deliberately not `Result<T, AppError>` — a rejected key is a normal
/// outcome of a successful round trip to the provider, not a transport
/// failure. [KeyValidationFailure] covers both cases (the provider said no,
/// or the request itself failed) because callers only need "did this key
/// work, and if not, what did the provider say" — see PROVIDERS.md § Key
/// management and CLAUDE.md hard rule #1.
sealed class KeyValidationResult {
  const KeyValidationResult();
}

final class KeyValidationSuccess extends KeyValidationResult {
  const KeyValidationSuccess({this.availableModels = const []});

  final List<String> availableModels;
}

final class KeyValidationFailure extends KeyValidationResult {
  const KeyValidationFailure(this.providerMessage, {this.statusCode});

  /// The provider's own error text (or, for a network-level failure, a
  /// description of what went wrong) — never a canned "invalid key"
  /// string. CLAUDE.md hard rule #1: "Surface the actual error text on
  /// failure."
  final String providerMessage;

  final int? statusCode;
}

class ChatMessage {
  const ChatMessage({required this.role, required this.content});

  final String role;
  final String content;
}

/// One LLM provider's adapter.
///
/// [validateKey] must issue a real minimal request to the provider and
/// only report success on a verified response — never fake, stub, or
/// optimistically assume success (CLAUDE.md hard rule #1). This is a
/// project non-negotiable following a sibling project that displayed a
/// successful "key added" confirmation without ever calling the API.
abstract interface class LlmAdapter {
  /// Stable id, e.g. "openrouter", "anthropic". Used as the secure-storage
  /// key namespace and for routing/settings display.
  String get providerId;

  String get displayName;

  /// False for local providers (Ollama, llama.cpp, LM Studio) — those get
  /// a reachability check instead of key validation, per PROVIDERS.md §
  /// Key management point 5.
  bool get requiresApiKey;

  Future<KeyValidationResult> validateKey(String apiKey);

  Future<Result<String, AppError>> complete({
    required String apiKey,
    required String model,
    required List<ChatMessage> messages,
  });
}
