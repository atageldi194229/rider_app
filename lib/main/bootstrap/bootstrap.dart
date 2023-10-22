import 'dart:async';

import 'package:asman_rider/firebase_notification_service/firebase_notification_service.dart';
import 'package:asman_rider/main/bootstrap/app_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

typedef AppBuilder = Future<Widget> Function(
  FirebaseMessaging firebaseMessaging,
  SharedPreferences sharedPreferences,
  StreamController<Exception> exceptionSrteam,
);

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      // Initialize the theme dependencies
      UITheme.initialize();

      // Initialize date formatting
      await initializeDateFormatting();

      StreamController<Exception> exceptionStream = StreamController();

      // final analyticsRepository = AnalyticsRepository(FirebaseAnalytics.instance);

      final firebaseMessaging = FirebaseMessaging.instance;

      const androidNotificationChannel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      FirebaseNotificationService(
        androidNotificationChannel: androidNotificationChannel,
        firebaseMessaging: firebaseMessaging,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      ).initNotifications();

      final blocObserver = AppBlocObserver(
        // analyticsRepository: analyticsRepository,
        exceptionStream: exceptionStream,
      );
      Bloc.observer = blocObserver;
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationSupportDirectory(),
      );

      // if (kDebugMode) {
      //   await HydratedBloc.storage.clear();
      // }

      final sharedPreferences = await SharedPreferences.getInstance();

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      // unawaited(MobileAds.instance.initialize());

      runApp(
        await builder(
          firebaseMessaging,
          sharedPreferences,
          exceptionStream,
        ),
      );
    },
    (exception, stackTrace) async {
      await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    },
  );
}
