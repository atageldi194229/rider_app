import 'dart:async';
import 'dart:math';

import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:intl/intl.dart';

class RideContentItem2 extends StatelessWidget {
  const RideContentItem2({super.key, required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return UICard(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(RideDetailPage.route(rideId: ride.id!));
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// ID & Trip status
        Padding(
          padding: const EdgeInsets.all(UISpacing.lg),
          child: Row(
            children: [
              Text(
                "#${ride.id}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              UIBadge(
                labelText: "${ride.statusTranslated}",
                backgroundColor: ride.statusColor?.toColor(),
                color: Colors.white,
              ),
            ],
          ),
        ),

        /// First Divider
        const Divider(height: 1),

        /// Loop trip orders
        Column(
          children: [
            ...ride.points!.map<Widget>(
              (point) => Padding(
                padding: const EdgeInsets.all(UISpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(UISpacing.xs).copyWith(right: UISpacing.sm),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${point.reference}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("${point.address}", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    UIBadge(
                      labelText: point.orderStateTranslated ?? '',
                      backgroundColor: point.orderStateColor?.toColor(),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const Divider(height: 1),

        /// Show progress indicator for time delay
        Padding(
          padding: const EdgeInsets.all(UISpacing.lg),
          child: _RideDeadlineView(ride: ride),
        ),
      ],
    );
  }

  Widget buildOrderRow(BuildContext context, String? address, String? deadline) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.circle,
          color: Colors.green,
        ),
        const SizedBox(width: UISpacing.md),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text("$address"),
                  const Spacer(),
                  Text("$deadline"),
                ],
              ),
              const UIDottedDivider(height: UISpacing.xlg),
            ],
          ),
        ),
      ],
    );
  }
}

class _RideDeadlineView extends StatefulWidget {
  const _RideDeadlineView({required this.ride});

  final Ride ride;

  @override
  State<_RideDeadlineView> createState() => _RideDeadlineViewState();
}

class _RideDeadlineViewState extends State<_RideDeadlineView> {
  double value = 0;
  bool isNotTime = false;
  bool isExpired = false;

  DateTime get dt1 => widget.ride.startDeadline!;
  DateTime get dt2 => widget.ride.completeDeadline!;

  Timer? _timer;

  @override
  void initState() {
    final now = DateTime.now();
    isNotTime = now.isBefore(dt1);
    isExpired = now.isAfter(dt2);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculate();

      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _calculate();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _calculate() {
    final now = DateTime.now();
    isNotTime = now.isBefore(dt1);
    isExpired = now.isAfter(dt2);

    if (isExpired) {
      value = 1.0;
      _timer?.cancel();
    }

    if (!isNotTime && !isExpired) {
      value = (now.millisecondsSinceEpoch - dt1.millisecondsSinceEpoch) / (dt2.millisecondsSinceEpoch - dt1.millisecondsSinceEpoch);
    }

    value = min(value, 1.0);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

    return Column(
      children: [
        /// must start & must complete time
        Row(
          children: [
            Text(DateFormat(DateFormat.HOUR24_MINUTE, context.l10n.localeName).format(dt1), style: textStyle),
            const Spacer(),
            Text(DateFormat(DateFormat.HOUR24_MINUTE, context.l10n.localeName).format(dt2), style: textStyle),
          ],
        ),

        const SizedBox(height: UISpacing.lg),

        /// Linear progress indicator
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(6.0),
          minHeight: 5.0,
          backgroundColor: isNotTime ? Colors.grey.shade300 : null,
          value: value,
          color: isExpired ? Colors.red : Colors.blue.shade700,
        ),
      ],
    );
  }
}
