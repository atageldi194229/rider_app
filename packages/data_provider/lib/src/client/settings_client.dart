import 'package:data_provider/data_provider.dart';

/// Settings client
class SettingsClient {
  /// Constructor
  const SettingsClient({
    required Http httpClient,
  }) : _http = httpClient;

  final Http _http;

  /// Update base url of the app
  void updateBaseUrl(String baseUrl) {
    _http.updateBaseUrl(baseUrl);
  }

  /// Update device firebase token
  Future<void> updateAppToken({
    required String fcmToken,
    String? device,
  }) async {
    await _http.post<dynamic>(
      '/api/riders/settings/device',
      data: {
        'device': device,
        'token': fcmToken,
      },
    );
  }

  /// Update app language
  Future<void> updateAppLocale(String locale) async {
    await _http.post<dynamic>(
      '/api/riders/settings/locale',
      data: {
        'locale': locale,
      },
    );
  }

  /// Update app user password
  Future<void> updateAppPassword(String password) async {
    await _http.post<dynamic>(
      '/api/riders/settings/password',
      data: {
        'password': password,
        'password_confirmation': password,
      },
    );
  }
}
