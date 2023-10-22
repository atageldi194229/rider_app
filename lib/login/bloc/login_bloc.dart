import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginState()) {
    on<LoginPhoneChanged>(_onLoginPhoneChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginStarted>(_onLoginStarted);

    // Only in debug mode
    if (kDebugMode) {
      add(const LoginPhoneChanged('99365027978'));
      // add(const LoginPhoneChanged('99364809000'));
      // add(const LoginPhoneChanged('99365535818'));
      add(const LoginPasswordChanged('123123'));
    }
  }

  final UserRepository _userRepository;

  FutureOr<void> _onLoginPhoneChanged(LoginPhoneChanged event, Emitter<LoginState> emit) {
    final phone = Phone.dirty(event.phone);

    emit(state.copyWith(
      phone: phone,
    ));
  }

  FutureOr<void> _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
      password: password,
    ));
  }

  FutureOr<void> _onLoginStarted(LoginStarted event, Emitter<LoginState> emit) async {
    if (!state.isLoginStartable) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _userRepository.logIn(
        phone: state.phone.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }
}
