enum ValidationStatus { idle, validating, success, failure }

class SettingsState {
  const SettingsState({
    required this.selectedProviderId,
    this.apiKeyInput = '',
    this.status = ValidationStatus.idle,
    this.errorMessage,
    this.savedKeyPresent = false,
  });

  final String selectedProviderId;
  final String apiKeyInput;
  final ValidationStatus status;
  final String? errorMessage;
  final bool savedKeyPresent;
}
