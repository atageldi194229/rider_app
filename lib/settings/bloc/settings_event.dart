part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsBaseUrlChanged extends SettingsEvent {
  final String? baseUrl;

  const SettingsBaseUrlChanged(this.baseUrl);

  @override
  List<Object?> get props => [baseUrl];
}

final class SettingsPasswordChanged extends SettingsEvent {
  final String password;

  const SettingsPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class SettingsSaveRequested extends SettingsEvent {}

final class SettingsDefaultSettingsRestored extends SettingsEvent {}

final class SettingsDeviceTokenUpdated extends SettingsEvent {}
