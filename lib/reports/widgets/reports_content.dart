import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class ReportsContent extends StatelessWidget {
  const ReportsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((ReportsBloc bloc) => bloc.state.status);
    final content = context.select((ReportsBloc bloc) => bloc.state.content);

    if (status == ReportsStatus.failure) {
      return NetworkError(
        onRetry: () => context.read<ReportsBloc>().add(const ReportsRequested()),
      );
    }

    if (status == ReportsStatus.idle || status == ReportsStatus.loading) {
      return const UILoader();
    }

    if (content != null) {
      return RefreshIndicator(
        onRefresh: () async => context.read<ReportsBloc>().add(const ReportsRequested()),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportDate.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportOrderCount.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportTotalOrder.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportDeliveryCost.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportWorkedTime.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportRating.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      context.l10n.reportEarnings.split(' ').join('\n'),
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: content
                  .map<DataRow>(
                    (dailyRide) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text('${dailyRide.day}')),
                        DataCell(Text('${dailyRide.count}')),
                        DataCell(Text('${dailyRide.total}')),
                        DataCell(Text('${dailyRide.deliveryCost}')),
                        DataCell(Text('${dailyRide.workingTime}')),
                        DataCell(Text('${dailyRide.rating}')),
                        DataCell(Text('${dailyRide.earnings}')),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
