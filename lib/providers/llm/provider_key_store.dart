import '../../core/storage/secure_storage.dart';

/// Namespaces provider API keys within [SecureStorage] — Keystore/Keychain
/// only, per CLAUDE.md hard rule #2. Never preferences, files, or logs.
class ProviderKeyStore {
  ProviderKeyStore(this._storage);

  final SecureStorage _storage;

  String _storageKeyFor(String providerId) => 'provider_key_$providerId';

  Future<String?> read(String providerId) =>
      _storage.read(_storageKeyFor(providerId));

  Future<void> write(String providerId, String apiKey) =>
      _storage.write(_storageKeyFor(providerId), apiKey);

  Future<void> delete(String providerId) =>
      _storage.delete(_storageKeyFor(providerId));
}
