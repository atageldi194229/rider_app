import 'dart:async';
import 'dart:math';

import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/ride_detail/ride_detail.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:intl/intl.dart';

class RideContentItem extends StatelessWidget {
  const RideContentItem({super.key, required this.ride});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(RideDetailPage.route(rideId: ride.id!));
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(UISpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              Chip(
                // padding: EdgeInsets.zero,
                label: Text("${ride.status?.name.toUpperCase()}", style: theme.textTheme.bodyLarge),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Spacer(),
              Text("#${ride.id}", style: theme.textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: UISpacing.md),
          _RideDeadlineView(ride: ride),
          const SizedBox(height: UISpacing.md),
          const Divider(height: UISpacing.xlg),
          ...ride.points!.map<Widget>(
            (point) => buildOrderRow(
              context,
              point.address,
              DateFormat(DateFormat.HOUR24_MINUTE, context.l10n.localeName).format(point.deadline!),
            ),
          ),
        ],
      ),
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
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: UISpacing.md),
        Text(DateFormat(DateFormat.HOUR24_MINUTE, context.l10n.localeName).format(dt1)),
        const SizedBox(width: UISpacing.md),
        Expanded(
          child: LinearProgressIndicator(
            backgroundColor: isNotTime ? Colors.orange : null,
            value: value,
            color: isExpired ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(width: UISpacing.md),
        Text(DateFormat(DateFormat.HOUR24_MINUTE, context.l10n.localeName).format(dt2)),
        const SizedBox(width: UISpacing.md),
        Icon(
          Icons.flag,
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }
}
