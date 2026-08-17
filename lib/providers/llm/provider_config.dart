/// Data row for one OpenAI-compatible provider. Adding a provider is
/// adding an entry here — not writing a new adapter class. See
/// PROVIDERS.md § LLM adapters and CLAUDE.md "When adding a provider".
class OpenAiCompatibleProviderConfig {
  const OpenAiCompatibleProviderConfig({
    required this.id,
    required this.displayName,
    required this.defaultBaseUrl,
    required this.keyFormatHint,
    required this.requiresApiKey,
  });

  final String id;
  final String displayName;
  final String defaultBaseUrl;
  final String keyFormatHint;

  /// False for local providers (Ollama, llama.cpp, LM Studio) — those get
  /// a reachability check instead of key validation.
  final bool requiresApiKey;
}

const List<OpenAiCompatibleProviderConfig> openAiCompatibleProviders = [
  OpenAiCompatibleProviderConfig(
    id: 'openrouter',
    displayName: 'OpenRouter',
    defaultBaseUrl: 'https://openrouter.ai/api/v1',
    keyFormatHint: 'sk-or-v1-…',
    requiresApiKey: true,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'openai',
    displayName: 'OpenAI',
    defaultBaseUrl: 'https://api.openai.com/v1',
    keyFormatHint: 'sk-proj-…',
    requiresApiKey: true,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'grok',
    displayName: 'xAI Grok',
    defaultBaseUrl: 'https://api.x.ai/v1',
    keyFormatHint: 'xai-…',
    requiresApiKey: true,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'deepseek',
    displayName: 'DeepSeek',
    defaultBaseUrl: 'https://api.deepseek.com/v1',
    keyFormatHint: 'sk-…',
    requiresApiKey: true,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'glm',
    displayName: 'Zhipu GLM',
    defaultBaseUrl: 'https://open.bigmodel.cn/api/paas/v4',
    keyFormatHint: 'id.secret pair',
    requiresApiKey: true,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'ollama',
    displayName: 'Ollama',
    // <host>:11434 in PROVIDERS.md — localhost default, host is editable
    // per install (see OpenAiCompatibleAdapter's baseUrlOverride).
    defaultBaseUrl: 'http://localhost:11434/v1',
    keyFormatHint: 'none',
    requiresApiKey: false,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'llamacpp',
    displayName: 'llama.cpp server',
    defaultBaseUrl: 'http://localhost:8080/v1',
    keyFormatHint: 'none',
    requiresApiKey: false,
  ),
  OpenAiCompatibleProviderConfig(
    id: 'lmstudio',
    displayName: 'LM Studio',
    defaultBaseUrl: 'http://localhost:1234/v1',
    keyFormatHint: 'none',
    requiresApiKey: false,
  ),
];
