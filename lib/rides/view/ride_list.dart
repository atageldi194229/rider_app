import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/profile/profile.dart';
import 'package:asman_rider/rides/rides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider_ui/rider_ui.dart';

class RideList extends StatelessWidget {
  const RideList({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((RideBloc bloc) => bloc.state.status);
    final rides = context.select((RideBloc bloc) => bloc.state.rides);
    final hasMoreRides = context.select((RideBloc bloc) => bloc.state.hasMoreRides);
    final isFailure = status == RideStatus.failure;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<RideBloc>().add(RideRefreshRequested());
        context.read<ProfileBloc>().add(ProfileRequested());
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: UISpacing.lg),
        padding: const EdgeInsets.all(UISpacing.lg),
        itemCount: rides.length + 1,
        itemBuilder: (context, index) {
          if (index == rides.length) {
            /// First: Check the failure status
            if (isFailure) {
              return NetworkError(
                onRetry: () => context.read<RideBloc>().add(RideRequested()),
              );
            }

            /// Second: Check if there more
            if (hasMoreRides) {
              return RideContentLoaderItem(
                onPresented: () => context.read<RideBloc>().add(RideRequested()),
              );
            }

            /// Third: Check for empty
            if (rides.isEmpty) {
              return SizedBox(
                height: .8.sh,
                child: Center(
                  child: Text(context.l10n.emptyList),
                ),
              );
            }

            return const SizedBox();
          }

          return RideContentItem2(ride: rides[index]);
        },
      ),
    );
  }
}
