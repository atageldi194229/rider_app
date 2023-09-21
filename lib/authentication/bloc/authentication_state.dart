part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial(),
  authenticated(),
  unauthenticated();
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
    this.user = User.anonymous,
  });

  const AuthenticationState.authenticated(
    User user,
  ) : this(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.initial()
      : this(
          status: AuthenticationStatus.initial,
        );

  const AuthenticationState.unauthenticated() : this(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object?> get props => [
        status,
        user,
      ];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
