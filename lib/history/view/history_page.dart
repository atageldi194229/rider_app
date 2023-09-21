import 'package:asman_rider/history/history.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_repository/ride_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(builder: (_) => const HistoryPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        rideRepository: context.read<RideRepository>(),
      ),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.history),
      ),
      body: const HistoryContent(),
    );
  }
}
