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
        onRetry: () => context.read<ReportsBloc>().add(ReportsRequested()),
      );
    }

    if (status == ReportsStatus.idle || status == ReportsStatus.loading) {
      return const UILoader();
    }

    if (content != null) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Day',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Count',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Sub.Total',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Delivery.Cost',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Discount.Total',
                    style: TextStyle(fontStyle: FontStyle.italic),
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
                      DataCell(Text('${dailyRide.subTotal}')),
                      DataCell(Text('${dailyRide.deliveryCost}')),
                      DataCell(Text('${dailyRide.discountTotal}')),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
