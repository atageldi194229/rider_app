import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ride_repository/ride_repository.dart';

part 'ride_detail_event.dart';
part 'ride_detail_state.dart';

class RideDetailBloc extends Bloc<RideDetailEvent, RideDetailState> {
  RideDetailBloc({
    required RideRepository rideRepository,
    required int rideId,
  })  : _rideRepository = rideRepository,
        _rideId = rideId,
        super(const RideDetailState.initial()) {
    on<RideDetailRequested>(_onRideDetailRequested);
    on<RideDetailOrderBarcodeRead>(_onRideDetailOrderBarcodeRead);
  }

  final RideRepository _rideRepository;
  final int _rideId;

  FutureOr<void> _onRideDetailRequested(RideDetailRequested event, Emitter<RideDetailState> emit) async {
    try {
      emit(state.copyWith(status: RideDetailStatus.loading));

      final rideDetail = await _rideRepository.getDetail(_rideId);

      emit(
        state.copyWith(
          status: RideDetailStatus.populated,
          rideDetail: rideDetail,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: RideDetailStatus.failure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onRideDetailOrderBarcodeRead(RideDetailOrderBarcodeRead event, Emitter<RideDetailState> emit) {
    final barcode = event.barcode.trim();

    emit(state.copyWith(
      readBarcodeList: {...state.readBarcodeList, barcode},
      readBarcodeError: null,
    ));
  }
}
