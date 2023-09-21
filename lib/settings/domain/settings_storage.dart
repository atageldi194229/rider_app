import 'package:storage/storage.dart';

/// Storage keys for the [SettingsStorage].
abstract class SettingsStorageKeys {
  /// Base URL
  static const appSettingsBaseUrl = '__app_settings_base_url_key__';

  /// App Language
  static const appSettingsLanguage = '__app_settings_language_key__';
}

/// {@template user_storage}
/// Storage for the UserRepository.
/// {@endtemplate}
class SettingsStorage {
  /// {@macro user_storage}
  const SettingsStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Sets the app base url.
  Future<void> setAppBaseUrl(String baseUrl) => _storage.write(
        key: SettingsStorageKeys.appSettingsBaseUrl,
        value: baseUrl,
      );

  /// Fetches the app base url.
  Future<String?> fetchAppBaseUrl() => _storage.read(key: SettingsStorageKeys.appSettingsBaseUrl);

  /// Sets the app language.
  Future<void> setAppLanguage(String language) => _storage.write(
        key: SettingsStorageKeys.appSettingsLanguage,
        value: language,
      );

  /// Fetches the app language.
  Future<String?> fetchAppLanguage() => _storage.read(key: SettingsStorageKeys.appSettingsLanguage);

  /// Clear The Settings Storage
  Future<void> clearAppSettings() {
    return _storage.clear();
  }
}
