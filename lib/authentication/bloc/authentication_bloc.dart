import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AuthenticationState.initial()) {
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    on<AuthenticationUserChanged>(_onUserChanged);

    _userSubscription = _userRepository.user.listen(_userChanged);

    // try authenticate on app initialization
    _authenticateViaSavedCredentials();
  }

  final UserRepository _userRepository;
  late StreamSubscription _userSubscription;

  void _userChanged(User user) => add(AuthenticationUserChanged(user));

  void _onLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    try {
      unawaited(_userRepository.logOut());
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _authenticateViaSavedCredentials() async {
    try {
      // start authentication
      // await Future.delayed(const Duration(seconds: 2));
      await _userRepository.logInWithSavedCredentials();
    } on LogInCancelled {
      add(const AuthenticationLogoutRequested());
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      add(const AuthenticationLogoutRequested());
    }
  }

  void _onUserChanged(AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    final user = event.user;

    if (user == User.anonymous) {
      emit(const AuthenticationState.unauthenticated());
    } else {
      emit(AuthenticationState.authenticated(user));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
