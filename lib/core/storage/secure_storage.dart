import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin wrapper around [FlutterSecureStorage].
///
/// Backed by Android Keystore / iOS Keychain. Never store secrets anywhere
/// else (preferences, files, constants, logs) — see CLAUDE.md hard rule #2.
///
/// This wrapper is generic key/value storage. Provider API keys and their
/// validation flow are added in the provider layer milestone, not here.
class SecureStorage {
  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();
}
