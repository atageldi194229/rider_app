import 'package:asman_rider/active_ride/active_ride.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailInformation extends StatelessWidget {
  const RideDetailInformation({required this.rideDetail, super.key});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(UISpacing.lg).copyWith(bottom: 0),
      sliver: SliverToBoxAdapter(
        child: UICard(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(UISpacing.lg),
                child: Row(
                  children: [
                    /// ID
                    Text("#${rideDetail.id}", style: theme.textTheme.titleLarge),
                    const Spacer(),
                    Text("${rideDetail.durationText}", style: theme.textTheme.titleLarge),
                  ],
                ),
              ),
              const Divider(height: 1),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "${rideDetail.statusTranslated?.toUpperCase()}",
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ActiveRideBloc, ActiveRideState>(
                    builder: (context, state) {
                      if (state.rideId == null || state.rideId != rideDetail.id) {
                        return const SizedBox();
                      }

                      if (state.status == ActiveRideStatus.loading) {
                        return const UILoader(
                          size: 24.0,
                          padding: EdgeInsets.all(UISpacing.md),
                        );
                      }

                      return IntrinsicHeight(
                        child: Row(
                          children: [
                            const VerticalDivider(width: 1),
                            IconButton(
                              onPressed: () => context.read<ActiveRideBloc>().add(ActiveRideTransferPressed()),
                              icon: const Icon(Icons.transfer_within_a_station),
                            ),
                            const VerticalDivider(width: 1),
                            IconButton(
                              onPressed: () => context.read<ActiveRideBloc>().add(ActiveRidePausePressed()),
                              icon: const Icon(Icons.pause),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
