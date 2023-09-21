import 'dart:async';

import 'package:asman_rider/navigation/navigation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'line_status_event.dart';
part 'line_status_state.dart';

class LineStatusBloc extends Bloc<LineStatusEvent, LineStatus> {
  LineStatusBloc({
    required LineStatusRepository lineStatusRepository,
  })  : _lineStatusRepository = lineStatusRepository,
        super(LineStatus.initial) {
    on<LineStatusStarted>(_onLineStatusStarted);
    on<LineStatusTogglePressed>(_onLineStatusTogglePressed);
  }

  final LineStatusRepository _lineStatusRepository;

  FutureOr<void> _onLineStatusStarted(LineStatusStarted event, Emitter<LineStatus> emit) async {
    emit(LineStatus.loading);

    try {
      final staff = await _lineStatusRepository.fetchCurrentLineStatus();
      final status = staff.status == 1;

      emit(switch (status) {
        true => LineStatus.online,
        false => LineStatus.offline,
      });

      // _streamStaffLocation(staff);
    } catch (error, stackTrace) {
      emit(LineStatus.failure);
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onLineStatusTogglePressed(LineStatusTogglePressed event, Emitter<LineStatus> emit) async {
    emit(LineStatus.loading);

    try {
      final staff = await _lineStatusRepository.updateLineStatus();
      final status = staff.status == 1;

      emit(switch (status) {
        true => LineStatus.online,
        false => LineStatus.offline,
      });

      // _streamStaffLocation(staff);
    } catch (error, stackTrace) {
      emit(LineStatus.failure);
      addError(error, stackTrace);
    }
  }

  // void _streamStaffLocation(Staff staff) {
  //   if (staff.status == 1) {
  //     TrackerService().add(TrackerStartRequested(riderId: staff.id!, warehouseId: staff.warehouseId!));
  //   } else {
  //     TrackerService().add(TrackerStopRequested());
  //   }
  // }
}
