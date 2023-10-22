import 'dart:io';

import 'package:asman_rider/app/app.dart';
import 'package:asman_rider/env/env.dart';
import 'package:asman_rider/main/bootstrap/bootstrap.dart';
import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:data_provider/data_provider.dart';
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap((
    firebaseMessaging,
    sharedPreferences,
    exceptionStream,
  ) async {
    /// Constants
    const defaultLanguage = 'en';
    const defaultBaseUrl = Env.serverUrl;

    /// Storages
    final tokenStorage = InMemoryTokenStorage();
    const secureStorage = SecureStorage();
    const userStorage = UserStorage(storage: secureStorage);
    const settingsStorage = SettingsStorage(storage: secureStorage);

    /// set default language
    await settingsStorage.setAppBaseUrl((await settingsStorage.fetchAppBaseUrl()) ?? defaultBaseUrl);
    await settingsStorage.setAppLanguage((await settingsStorage.fetchAppLanguage()) ?? defaultLanguage);

    /// HTTP Client
    final httpClient = Http(
      defaultBaseUrl: defaultBaseUrl,
      tokenProvider: tokenStorage.readToken,
      languageProvider: settingsStorage.fetchAppLanguage,
    );

    /// Only for development
    HttpOverrides.global = MyHttpOverrides();

    /// Settings
    final settingsClient = SettingsClient(httpClient: httpClient);

    final settingsRepository = SettingsRepository(
      firebaseMessaging: firebaseMessaging,
      settingsClient: settingsClient,
      settingsStorage: settingsStorage,
      defaultBaseUrl: defaultBaseUrl,
      defaultLanguage: defaultLanguage,
    );

    /// Authentication and User
    final authenticationClient = AuthenticationClient(
      httpClient: httpClient,
      tokenStorage: tokenStorage,
    );

    final profileClient = ProfileClient(httpClient: httpClient);

    final userRepository = UserRepository(
      fcmTokenProvider: () async {
        final String? token = await firebaseMessaging.getToken();
        return token;
      },
      authenticationClient: authenticationClient,
      storage: userStorage,
      profileClient: profileClient,
    );

    /// User line status
    final lineStatusClient = LineStatusClient(httpClient: httpClient);
    final lineStatusRepository = LineStatusRepository(lineStatusClient: lineStatusClient);

    /// Ride
    final rideClient = RideClient(httpClient: httpClient);
    final rideRepository = RideRepository(rideClient: rideClient);

    /// Orders
    final orderClient = OrderClient(httpClient: httpClient);
    final orderRepository = OrderRepository(orderClient: orderClient);

    return App(
      settingsRepository: settingsRepository,
      userRepository: userRepository,
      lineStatusRepository: lineStatusRepository,
      rideRepository: rideRepository,
      orderRepository: orderRepository,
      exceptionStream: exceptionStream,
    );
  });
}
