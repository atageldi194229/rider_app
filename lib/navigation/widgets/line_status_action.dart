import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/config/config.dart';
import 'package:asman_rider/location_tracker/location_tracker.dart';
import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class LineStatusAction extends StatelessWidget {
  const LineStatusAction({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((LineStatusBloc bloc) => bloc.state);
    final (staffId, staffWarehouseId) = context.select((ProfileBloc bloc) => (bloc.state.riderState?.id, bloc.state.riderState?.warehouseId));
    final appConfig = context.select((AppConfigBloc bloc) => bloc.state.appConfig);
    final activeRideId = context.select((ActiveRideBloc bloc) => bloc.state.rideId);

    if (status == LineStatus.online && staffId != null && staffWarehouseId != null && appConfig != null) {
      context.read<LocationTrackerBloc>().add(LocationTrackerStartRequested(
            riderId: staffId,
            warehouseId: staffWarehouseId,
            activeRideId: activeRideId,
            sendIntervalInSeconds: appConfig.grpcSeconds ?? 4,
            grpcUrl: appConfig.grpcUrl!,
          ));
    }

    if (status == LineStatus.offline) {
      context.read<LocationTrackerBloc>().add(LocationTrackerStopRequested());
    }
    return switch (status) {
      LineStatus.online => const OnlineButton(),
      LineStatus.offline => const OfflineButton(),
      LineStatus.failure => const WarningButton(),
      _ => const LinStatusLoader(),
    };
  }
}

class LinStatusLoader extends StatelessWidget {
  const LinStatusLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = IconTheme.of(context).size;

    return IconButton(
      onPressed: () {},
      icon: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

class OnlineButton extends StatelessWidget {
  const OnlineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<LineStatusBloc>().add(LineStatusTogglePressed()),
      icon: const Icon(Icons.radio_button_checked, color: UIColors.green),
    );
  }
}

class OfflineButton extends StatelessWidget {
  const OfflineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<LineStatusBloc>().add(LineStatusTogglePressed()),
      icon: const Icon(Icons.radio_button_checked, color: UIColors.red),
    );
  }
}

class WarningButton extends StatelessWidget {
  const WarningButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<LineStatusBloc>().add(LineStatusTogglePressed()),
      icon: const Icon(Icons.radio_button_checked, color: UIColors.orange),
    );
  }
}
