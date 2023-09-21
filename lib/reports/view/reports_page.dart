import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_repository/order_repository.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute(builder: (_) => const ReportsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsBloc(
        orderRepository: context.read<OrderRepository>(),
      )..add(ReportsRequested()),
      child: const ReportsView(),
    );
  }
}

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.reports),
      ),
      body: const ReportsContent(),
    );
  }
}
