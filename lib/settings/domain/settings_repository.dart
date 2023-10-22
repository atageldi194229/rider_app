import 'package:asman_rider/settings/settings.dart';
import 'package:data_provider/data_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Base class for settings failures
sealed class SettingsException implements Exception {
  const SettingsException(this.error);

  final Object error;
}

/// UpdateBaseUrlFailure
final class UpdateBaseUrlFailure extends SettingsException {
  const UpdateBaseUrlFailure(super.error);
}

/// GetBaseUrlFailure
final class GetBaseUrlFailure extends SettingsException {
  const GetBaseUrlFailure(super.error);
}

/// UpdateFCMTokenFailure
final class UpdateFCMTokenFailure extends SettingsException {
  const UpdateFCMTokenFailure(super.error);
}

/// GetFCMTokenFailure
final class GetFCMTokenFailure implements Exception {
  const GetFCMTokenFailure();
}

/// UpdateAppPasswordFailure
final class UpdateAppPasswordFailure extends SettingsException {
  const UpdateAppPasswordFailure(super.error);
}

/// UpdateAppLanguageFailure
final class UpdateAppLanguageFailure extends SettingsException {
  const UpdateAppLanguageFailure(super.error);
}

/// GetAppLanguageFailure
final class GetAppLanguageFailure extends SettingsException {
  const GetAppLanguageFailure(super.error);
}

/// GetAppConfigFailure
final class GetAppConfigFailure extends SettingsException {
  const GetAppConfigFailure(super.error);
}

/// SettingsRepository
final class SettingsRepository {
  /// SettingsRepository constructor
  SettingsRepository({
    required FirebaseMessaging firebaseMessaging,
    required SettingsClient settingsClient,
    required SettingsStorage settingsStorage,
    required String defaultBaseUrl,
    String defaultLanguage = 'en',
  })  : _firebaseMessaging = firebaseMessaging,
        _settingsClient = settingsClient,
        _settingsStorage = settingsStorage,
        _defaultBaseUrl = defaultBaseUrl,
        _defaultLanguage = defaultLanguage {
    getBaseUrl().then((baseUrl) => updateBaseUrl(baseUrl));
  }

  final FirebaseMessaging _firebaseMessaging;
  final SettingsClient _settingsClient;
  final SettingsStorage _settingsStorage;
  final String _defaultBaseUrl;
  final String _defaultLanguage;

  /// Update base url of the app in the storage
  Future<void> updateBaseUrl(String? baseUrl) async {
    try {
      _settingsClient.updateBaseUrl(baseUrl ?? _defaultBaseUrl);
      await _settingsStorage.setAppBaseUrl(baseUrl ?? _defaultBaseUrl);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateBaseUrlFailure(error), stackTrace);
    }
  }

  /// Get base url off app from storage
  Future<String> getBaseUrl() async {
    try {
      final baseUrl = await _settingsStorage.fetchAppBaseUrl();
      return baseUrl ?? _defaultBaseUrl;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetBaseUrlFailure(error), stackTrace);
    }
  }

  /// Update language of the app in the storage
  Future<void> updateLanguage(String? language) async {
    try {
      _settingsClient.updateAppLocale(language ?? _defaultLanguage);
      await _settingsStorage.setAppLanguage(language ?? _defaultLanguage);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateAppLanguageFailure(error), stackTrace);
    }
  }

  /// Get language off app from storage
  Future<String> getLanguage() async {
    try {
      final language = await _settingsStorage.fetchAppLanguage();
      return language ?? _defaultLanguage;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetAppLanguageFailure(error), stackTrace);
    }
  }

  /// Send firebase token to server
  Future<void> updateDeviceToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      assert(fcmToken != null);

      if (fcmToken == null) {
        throw const GetFCMTokenFailure();
      }

      final device = await _getDeviceName();
      await _settingsClient.updateAppToken(
        fcmToken: fcmToken,
        device: device,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateFCMTokenFailure(error), stackTrace);
    }
  }

  /// Get the device name
  Future<String> _getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
    return build.model;
  }

  /// Update app user password
  Future<void> updateAppPassword(String password) async {
    try {
      await _settingsClient.updateAppPassword(password);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateAppPasswordFailure(error), stackTrace);
    }
  }

  /// Get app config
  Future<AppConfig> getAppConfig() async {
    try {
      final response = await _settingsClient.getAppConfig();
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetAppConfigFailure(error), stackTrace);
    }
  }
}
