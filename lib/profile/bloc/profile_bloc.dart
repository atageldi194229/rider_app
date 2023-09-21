import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required userRepository,
  })  : _userRepository = userRepository,
        super(const ProfileState.initial()) {
    on<ProfileRequested>(_onProfileRequested);
  }

  final UserRepository _userRepository;

  FutureOr<void> _onProfileRequested(ProfileRequested event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final RiderState riderState = await _userRepository.getState();
      emit(state.copyWith(
        status: ProfileStatus.populated,
        riderState: riderState,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProfileStatus.failure));
      addError(error, stackTrace);
    }
  }
}
