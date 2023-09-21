import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailActionButton extends StatelessWidget {
  const RideDetailActionButton({required this.rideDetail, super.key});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    final activeRideId = context.select((ActiveRideBloc bloc) => bloc.state.rideId);
    final isAllOrdersRead = context.select((RideDetailBloc bloc) => bloc.state.isAllOrdersRead);

    final bool hasActiveRide = activeRideId != null;
    final bool isCurrentRideActive = rideDetail.id == activeRideId;

    return SliverPadding(
      padding: const EdgeInsets.all(UISpacing.lg).copyWith(top: 0),
      sliver: SliverList.list(
        children: [
          /// Start action
          if ((hasActiveRide, isAllOrdersRead) == (false, true)) ...[
            _StartActionButton(rideDetail.id!),
            const SizedBox(height: UISpacing.lg),
          ],

          /// Complete action
          if ((hasActiveRide, isCurrentRideActive) == (true, true)) ...[
            const _CompleteActionButton(),
            const SizedBox(height: UISpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _StartActionButton extends StatelessWidget {
  const _StartActionButton(this.rideId);

  final int rideId;

  @override
  Widget build(BuildContext context) {
    return UIActionButton(
      action: () async {
        final bloc = context.read<ActiveRideBloc>();
        bloc.add(ActiveRideStartPressed(rideId));

        /// Wait until result
        ActiveRideState state;
        do {
          state = await bloc.stream.first;
        } while (state.status == ActiveRideStatus.loading);
      },
      text: context.l10n.start.toUpperCase(),
    );
  }
}

class _CompleteActionButton extends StatelessWidget {
  const _CompleteActionButton();

  @override
  Widget build(BuildContext context) {
    return UIActionButton(
      action: () async {
        final bloc = context.read<ActiveRideBloc>();
        bloc.add(ActiveRideCompletePressed());

        /// Wait until result
        ActiveRideState state;
        do {
          state = await bloc.stream.first;
        } while (state.status == ActiveRideStatus.completingRide);
      },
      text: context.l10n.complete.toUpperCase(),
    );
  }
}
