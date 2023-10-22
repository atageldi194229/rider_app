import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

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

  @Deprecated("Unused method")
  onSelectItem(BuildContext context, BottomNavBarItemType type) {
    final rideId = context.read<ActiveRideBloc>().state.rideId;

    if (type == BottomNavBarItemType.activeRide && rideId != null) {
      Navigator.of(context).push(RideDetailPage.route(rideId: rideId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const labelStyle = TextStyle(fontSize: 12);
    final activeColor = theme.colorScheme.primary;
    final unselectedColor = theme.colorScheme.outline;
    Color backgroundColor = theme.colorScheme.primaryContainer;

    if (theme.colorScheme.brightness == Brightness.light) {
      backgroundColor = Colors.white;
    }

    final activeRideIcon = Icon(Icons.play_arrow_rounded, color: unselectedColor);

    // int currentIndex = itemTypes.indexWhere((e) => e == current);

    final hasActiveRide = context.select((ActiveRideBloc bloc) => bloc.state.rideId != null);

    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: UICard(
        color: backgroundColor,
        borderRadius: BorderRadius.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.home_rounded, color: activeColor),
                    Text(
                      context.l10n.rides,
                      style: labelStyle.copyWith(color: activeColor),
                    ),
                  ],
                ),
              ),
            ),
            // const VerticalDivider(width: 1),
            Expanded(
              child: InkWell(
                onTap: () {
                  final rideId = context.read<ActiveRideBloc>().state.rideId;

                  if (rideId != null) {
                    Navigator.of(context).push(RideDetailPage.route(rideId: rideId));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    hasActiveRide ? Badge(child: activeRideIcon) : activeRideIcon,
                    Text(
                      context.l10n.activeRide,
                      style: labelStyle.copyWith(color: unselectedColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
