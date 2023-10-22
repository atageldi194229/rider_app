import 'dart:async';
import 'dart:developer';

import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/app/app.dart';
import 'package:asman_rider/authentication/authentication.dart';
import 'package:asman_rider/config/config.dart';
import 'package:asman_rider/exception_handler/exception_handler.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/language/language.dart';
import 'package:asman_rider/location_tracker/location_tracker.dart';
import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/profile/profile.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:asman_rider/theme_selector/theme_selector.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_repository/order_repository.dart';
import 'package:ride_repository/ride_repository.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required SettingsRepository settingsRepository,
    required UserRepository userRepository,
    required LineStatusRepository lineStatusRepository,
    required RideRepository rideRepository,
    required OrderRepository orderRepository,
    required StreamController<Exception> exceptionStream,
    super.key,
  })  : _settingsRepository = settingsRepository,
        _userRepository = userRepository,
        _lineStatusRepository = lineStatusRepository,
        _rideRepository = rideRepository,
        _orderRepository = orderRepository,
        _exceptionStream = exceptionStream;

  final StreamController<Exception> _exceptionStream;
  final LineStatusRepository _lineStatusRepository;
  final OrderRepository _orderRepository;
  final RideRepository _rideRepository;
  final UserRepository _userRepository;
  final SettingsRepository _settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _settingsRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _lineStatusRepository),
        RepositoryProvider.value(value: _rideRepository),
        RepositoryProvider.value(value: _orderRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthenticationBloc(userRepository: _userRepository)),
          BlocProvider(create: (_) => ActiveRideBloc(rideRepository: _rideRepository)),
          BlocProvider(create: (_) => ProfileBloc(userRepository: _userRepository)),
          BlocProvider(create: (_) => ExceptionHandlerBloc(exceptionStream: _exceptionStream)),
          BlocProvider(create: (_) => LocationTrackerBloc()),
          BlocProvider(create: (_) => ThemeModeBloc()),
          BlocProvider(create: (_) => LanguageBloc(settingsRepository: _settingsRepository)),
          BlocProvider(create: (_) => SettingsBloc(settingsRepository: _settingsRepository)),
          BlocProvider(create: (_) => AppConfigBloc(settingsRepository: _settingsRepository)..add(AppConfigRequested())),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  context.read<ProfileBloc>().add(ProfileRequested());
                  context.read<SettingsBloc>().add(SettingsDeviceTokenUpdated());
                } else if (state.status == AuthenticationStatus.unauthenticated) {
                  context.read<LocationTrackerBloc>().add(LocationTrackerStopRequested());
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) => previous.riderState != current.riderState,
              listener: (context, state) {
                if (state.riderState != null) {
                  if (state.riderState?.activeRideId == null) {
                    // Empty the active ride state
                    context.read<ActiveRideBloc>().add(ActiveRideEmptied());
                  } else {
                    // If the active ride is exist
                    context.read<ActiveRideBloc>().add(ActiveRideLoaded(state.riderState!.activeRideId!));
                  }
                }
              },
            ),
          ],
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ScreenUtilInit(
                designSize: Size(constraints.maxWidth, constraints.maxHeight),
                builder: (context, constraints) {
                  return AppView(exceptionStream: _exceptionStream);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.exceptionStream});

  final StreamController<Exception> exceptionStream;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LanguageBloc, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              locale: locale,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: const UITheme().themeData,
              darkTheme: const UIDarkTheme().themeData,
              localizationsDelegates: const [
                TkMaterialLocalizations.delegate,
                TkCupertinoLocalizations.delegate,
                ...AppLocalizations.localizationsDelegates,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: ExceptionHandlerView(
                child: FlowBuilder<AuthenticationStatus>(
                  state: context.select((AuthenticationBloc bloc) => bloc.state.status),
                  onGeneratePages: onGenerateAppViewPages,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AppLifeCycleStateLogger extends StatefulWidget {
  const AppLifeCycleStateLogger({this.child, super.key});

  final Widget? child;

  @override
  State<AppLifeCycleStateLogger> createState() => _AppLifeCycleStateLoggerState();
}

class _AppLifeCycleStateLoggerState extends State<AppLifeCycleStateLogger> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log("$state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
