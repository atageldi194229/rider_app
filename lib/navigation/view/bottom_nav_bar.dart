import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavBarItemType {
  rides,
  activeRide,
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    this.current = BottomNavBarItemType.rides,
    super.key,
  });

  final BottomNavBarItemType current;

  List<BottomNavBarItemType> get itemTypes => [
        BottomNavBarItemType.rides,
        BottomNavBarItemType.activeRide,
      ];

  onSelectItem(BuildContext context, BottomNavBarItemType type) {
    final rideId = context.read<ActiveRideBloc>().state.rideId;

    if (type == BottomNavBarItemType.activeRide && rideId != null) {
      Navigator.of(context).push(RideDetailPage.route(rideId: rideId));
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = itemTypes.indexWhere((e) => e == current);

    final hasActiveRide = context.select((ActiveRideBloc bloc) => bloc.state.rideId != null);

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: context.l10n.rides,
        ),
        BottomNavigationBarItem(
          icon: hasActiveRide
              ? const Badge(
                  child: Icon(Icons.play_arrow_rounded),
                )
              : const Icon(Icons.play_arrow_rounded),
          label: context.l10n.activeRide,
        ),
      ],
      currentIndex: currentIndex,
      onTap: (value) => onSelectItem(context, itemTypes[value]),
    );
  }
}
