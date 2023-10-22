part of 'app_config_bloc.dart';

final class AppConfigState extends Equatable {
  const AppConfigState({
    this.appConfig,
  });

  const AppConfigState.initial() : this(appConfig: null);

  final AppConfig? appConfig;

  @override
  List<Object?> get props => [appConfig];
}
