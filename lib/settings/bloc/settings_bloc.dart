import 'dart:async';

import 'package:asman_rider/env/env.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const SettingsState.initial()) {
    on<SettingsBaseUrlChanged>(_baseUrlChanged);
    on<SettingsDefaultSettingsRestored>(_onDefaultSettingsRestored);
    on<SettingsDeviceTokenUpdated>(_onDeviceTokenUpdated);
    on<SettingsPasswordChanged>(_onPasswordChanged);

    // initialize, get base url from phone storage
    _settingsRepository.getBaseUrl().then((value) => add(SettingsBaseUrlChanged(value)));
  }

  final SettingsRepository _settingsRepository;

  FutureOr<void> _baseUrlChanged(SettingsBaseUrlChanged event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateBaseUrl(event.baseUrl);
      emit(state.copyWith(
        status: SettingsStatus.updatingSucceeded,
        baseUrl: event.baseUrl != null ? BaseUrl.dirty(event.baseUrl!) : null,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onDeviceTokenUpdated(SettingsDeviceTokenUpdated event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateDeviceToken();
      emit(state.copyWith(status: SettingsStatus.updatingSucceeded));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onPasswordChanged(SettingsPasswordChanged event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateAppPassword(event.password);
      emit(state.copyWith(status: SettingsStatus.updatingSucceeded));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onDefaultSettingsRestored(SettingsDefaultSettingsRestored event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateBaseUrl(null);
      emit(state.copyWith(status: SettingsStatus.updatingSucceeded));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }
}
