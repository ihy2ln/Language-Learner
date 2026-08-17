import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/llm/llm_providers.dart';
import 'settings_controller.dart';
import 'settings_state.dart';

/// Minimal settings screen for entering and validating provider keys —
/// the only UI this milestone adds beyond the review flow, per the
/// provider-layer scope in the kickoff notes.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final adapters = ref.watch(llmAdaptersProvider);
    final selectedAdapter = adapters[state.selectedProviderId];
    final needsKey = selectedAdapter?.requiresApiKey ?? true;
    final isValidating = state.status == ValidationStatus.validating;

    return Scaffold(
      appBar: AppBar(title: const Text('Provider keys')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              key: const Key('provider-dropdown'),
              initialValue: state.selectedProviderId,
              decoration: const InputDecoration(labelText: 'Provider'),
              items: [
                for (final id in allLlmProviderIds)
                  DropdownMenuItem(
                    value: id,
                    child: Text(adapters[id]?.displayName ?? id),
                  ),
              ],
              onChanged: (value) {
                if (value != null) controller.selectProvider(value);
              },
            ),
            const SizedBox(height: 12),
            if (!needsKey)
              const Text(
                'Local provider — no key needed. Validating just checks '
                "it's reachable.",
              )
            else
              TextField(
                key: const Key('api-key-field'),
                obscureText: true,
                onChanged: controller.updateApiKeyInput,
                decoration: const InputDecoration(labelText: 'API key'),
              ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('validate-save-button'),
              onPressed: isValidating ? null : controller.validateAndSave,
              child: isValidating
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Validate & save'),
            ),
            const SizedBox(height: 16),
            if (state.status == ValidationStatus.success)
              const Text(
                'Verified and saved.',
                key: Key('validation-success'),
                style: TextStyle(color: Colors.green),
              )
            else if (state.status == ValidationStatus.failure)
              Text(
                state.errorMessage ?? 'Validation failed.',
                key: const Key('validation-error'),
                style: const TextStyle(color: Colors.red),
              )
            else if (state.savedKeyPresent)
              const Text('A key is already saved for this provider.'),
          ],
        ),
      ),
    );
  }
}
