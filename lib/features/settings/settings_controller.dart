import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/llm/llm_adapter.dart';
import '../../providers/llm/llm_providers.dart';
import '../../providers/llm/provider_config.dart';
import 'settings_state.dart';

/// The full list of configured provider ids — the OpenAI-compatible row
/// in PROVIDERS.md's table plus the two bespoke ones.
List<String> get allLlmProviderIds => [
      for (final config in openAiCompatibleProviders) config.id,
      'anthropic',
      'gemini',
    ];

class SettingsController extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    final initialProviderId = allLlmProviderIds.first;
    _loadSavedKeyPresence(initialProviderId);
    return SettingsState(selectedProviderId: initialProviderId);
  }

  void selectProvider(String providerId) {
    state = SettingsState(selectedProviderId: providerId);
    _loadSavedKeyPresence(providerId);
  }

  void updateApiKeyInput(String value) {
    state = SettingsState(
      selectedProviderId: state.selectedProviderId,
      apiKeyInput: value,
      savedKeyPresent: state.savedKeyPresent,
    );
  }

  Future<void> _loadSavedKeyPresence(String providerId) async {
    final existing = await ref.read(providerKeyStoreProvider).read(providerId);
    if (state.selectedProviderId != providerId) return;
    state = SettingsState(
      selectedProviderId: state.selectedProviderId,
      apiKeyInput: state.apiKeyInput,
      savedKeyPresent: existing != null && existing.isNotEmpty,
    );
  }

  /// Issues a real request to the provider (CLAUDE.md hard rule #1) and
  /// only saves the key — to secure storage, never anywhere else — once
  /// that request comes back successful.
  Future<void> validateAndSave() async {
    final providerId = state.selectedProviderId;
    final adapter = ref.read(llmAdaptersProvider)[providerId];
    if (adapter == null) return;

    state = SettingsState(
      selectedProviderId: providerId,
      apiKeyInput: state.apiKeyInput,
      status: ValidationStatus.validating,
      savedKeyPresent: state.savedKeyPresent,
    );

    final result = await adapter.validateKey(state.apiKeyInput);

    switch (result) {
      case KeyValidationSuccess():
        await ref
            .read(providerKeyStoreProvider)
            .write(providerId, state.apiKeyInput);
        state = SettingsState(
          selectedProviderId: providerId,
          apiKeyInput: state.apiKeyInput,
          status: ValidationStatus.success,
          savedKeyPresent: true,
        );
      case KeyValidationFailure(providerMessage: final message):
        state = SettingsState(
          selectedProviderId: providerId,
          apiKeyInput: state.apiKeyInput,
          status: ValidationStatus.failure,
          errorMessage: message,
          savedKeyPresent: state.savedKeyPresent,
        );
    }
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, SettingsState>(
  SettingsController.new,
);
