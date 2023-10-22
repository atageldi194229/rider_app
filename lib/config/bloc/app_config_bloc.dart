import 'dart:async';

import 'package:asman_rider/settings/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const AppConfigState.initial()) {
    on<AppConfigRequested>(_onAppConfigRequested);
  }

  final SettingsRepository _settingsRepository;

  FutureOr<void> _onAppConfigRequested(AppConfigRequested event, Emitter<AppConfigState> emit) async {
    try {
      final appConfig = await _settingsRepository.getAppConfig();
      emit(AppConfigState(appConfig: appConfig));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}
