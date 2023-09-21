import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/rides/rides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_repository/ride_repository.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({super.key});

  /// Route constructor to display the widget inside a [Scaffold].
  static Route<void> route() {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => const RidesPage(),
    );
  }

  static Page<void> page() => const MaterialPage<void>(child: RidesPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RideBloc(
        rideRepository: context.read<RideRepository>(),
      ),
      child: const RidesView(),
    );
  }
}

class RidesView extends StatelessWidget {
  const RidesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveRideBloc, ActiveRideState>(
      listenWhen: (previous, current) => previous.rideId != current.rideId,
      listener: (context, state) {
        context.read<RideBloc>().add(RideRefreshRequested());
      },
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: NavAppBar(
          title: Text(context.l10n.rides),
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: const RideList(),
      ),
    );
  }
}
