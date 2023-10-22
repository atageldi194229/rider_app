import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class RideDetailInformation2 extends StatelessWidget {
  const RideDetailInformation2({required this.rideDetail, super.key});

  final RideDetail rideDetail;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: UICard(
        borderRadius: BorderRadius.zero,
        // elevation: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(UISpacing.xlg),
              child: Row(
                children: [
                  /// ID
                  Text(
                    "#${rideDetail.id}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Text("${rideDetail.durationText}", style: theme.textTheme.titleLarge),
                  if (rideDetail.statusTranslated != null)
                    UIBadge(
                      labelText: "${rideDetail.statusTranslated}",
                      backgroundColor: rideDetail.statusColor?.toColor(),
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
