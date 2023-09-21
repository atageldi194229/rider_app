import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailContent extends StatelessWidget {
  const RideDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((RideDetailBloc bloc) => bloc.state.status);
    final rideDetail = context.select((RideDetailBloc bloc) => bloc.state.rideDetail);

    /// Show loader item
    if (status == RideDetailStatus.initial || status == RideDetailStatus.loading) {
      return const UILoader();
    }

    /// Showed when ride detail load failure
    if (status == RideDetailStatus.failure) {
      return NetworkError(
        onRetry: () => context.read<RideDetailBloc>().add(RideDetailRequested()),
      );
    }

    /// Showed when ride detail loaded
    if (rideDetail != null) {
      return CustomScrollView(
        slivers: [
          RideDetailMap(rideDetail: rideDetail),
          RideDetailInformation(rideDetail: rideDetail),
          RideDetailContentList(orders: rideDetail.orders ?? []),
          RideDetailActionButton(rideDetail: rideDetail),
        ],
      );
    }

    /// Otherwise show
    return const SizedBox();
  }
}
