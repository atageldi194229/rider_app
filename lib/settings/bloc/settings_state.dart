// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

enum SettingsStatus {
  idle,

  updating,
  updatingFailure,
  updatingSucceeded,
}

final class SettingsState extends Equatable {
  const SettingsState({
    required this.status,
    this.baseUrl = const BaseUrl.pure(Env.serverUrl),
    this.password = const Password.pure(),
  });

  const SettingsState.initial() : this(status: SettingsStatus.idle);

  final SettingsStatus status;
  final BaseUrl baseUrl;
  final Password password;

  bool get isValid => Formz.validate([baseUrl, password]);

  @override
  List<Object> get props => [status, baseUrl, password];

  SettingsState copyWith({
    SettingsStatus? status,
    BaseUrl? baseUrl,
    Password? password,
  }) {
    return SettingsState(
      status: status ?? this.status,
      baseUrl: baseUrl ?? this.baseUrl,
      password: password ?? this.password,
    );
  }
}
