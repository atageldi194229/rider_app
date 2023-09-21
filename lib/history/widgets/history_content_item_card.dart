import 'package:asman_rider/l10n/l10n.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_ui/rider_ui.dart';

class HistoryContentItemCard extends StatelessWidget {
  const HistoryContentItemCard({super.key, required this.historyItem});

  final HistoryItem historyItem;

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      "ID": "${historyItem.id}",
      context.l10n.zoneId: "${historyItem.zoneId}",
      context.l10n.distanceText: "${historyItem.distanceText}",
      context.l10n.durationText: "${historyItem.durationText}",
      context.l10n.status: "${historyItem.statusTrans}",
      context.l10n.startedAt: DateFormat('yyyy-MM-dd hh:mm').format(historyItem.startedAt!),
      context.l10n.completedAt: DateFormat('yyyy-MM-dd hh:mm').format(historyItem.completedAt!),
      context.l10n.differenceInMinutes: "${historyItem.diffInMin}",
    };

    return UICard(
      child: ListView.separated(
        padding: const EdgeInsets.all(UISpacing.lg),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.entries.length,
        itemBuilder: (context, index) {
          final entry = data.entries.elementAt(index);
          return UIDataRow(entry.key.toUpperCase(), entry.value);
        },
        separatorBuilder: (_, __) => const SizedBox(height: UISpacing.sm),
      ),
    );
  }
}
