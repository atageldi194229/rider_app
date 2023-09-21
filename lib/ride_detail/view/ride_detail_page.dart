import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_repository/ride_repository.dart';

class RideDetailPage extends StatelessWidget {
  const RideDetailPage({required this.rideId, super.key});

  final int rideId;

  static Route<void> route({required int rideId}) {
    return MaterialPageRoute<void>(builder: (_) => RideDetailPage(rideId: rideId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RideDetailBloc(
        rideId: rideId,
        rideRepository: context.read<RideRepository>(),
      )..add(RideDetailRequested()),
      child: const RideDetailView(),
    );
  }
}

class RideDetailView extends StatelessWidget {
  const RideDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveRideBloc, ActiveRideState>(
      listenWhen: (previous, current) => (previous.status, current.status) == (ActiveRideStatus.completingRide, ActiveRideStatus.completingRideSucceeded),
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.rideDetail),
        ),
        body: const RideDetailContent(),
      ),
    );
  }
}
