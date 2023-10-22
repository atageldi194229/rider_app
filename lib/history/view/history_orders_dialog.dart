import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_repository/ride_repository.dart';
import 'package:rider_ui/rider_ui.dart';

class HistoryOrdersDialog extends StatelessWidget {
  const HistoryOrdersDialog({super.key, required this.rideId});

  final int rideId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rideDetailBloc = RideDetailBloc(
      rideRepository: context.read<RideRepository>(),
      rideId: rideId,
    )..add(RideDetailRequested());

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom * 1.3),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: UISpacing.lg, vertical: UISpacing.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UISpacing.xlg, vertical: UISpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.rideDetail,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: UISpacing.lg),
              Expanded(
                child: BlocBuilder<RideDetailBloc, RideDetailState>(
                  bloc: rideDetailBloc,
                  builder: (context, state) {
                    final status = state.status;
                    final rideDetail = state.rideDetail;

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
                    if (rideDetail?.orders != null) {
                      return ListView.separated(
                        // mainAxisSize: MainAxisSize.min,
                        shrinkWrap: true,
                        itemCount: rideDetail!.orders!.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final order = rideDetail.orders![index];

                          return UICard(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(OrderLinesPage.route(
                                  orderId: order.orderId!,
                                  pointId: order.pointId!,
                                  mode: OrderLinesMode.readOnly,
                                ));
                              },
                              child: OrderItemCardHeader(
                                order: order,
                              ),
                            ),
                          );
                        },
                      );
                    }

                    /// Otherwise show
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
