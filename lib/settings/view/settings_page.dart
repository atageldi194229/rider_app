import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute<void>(builder: (_) => const SettingsPage());

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        actions: [
          IconButton(
            onPressed: () => context.read<SettingsBloc>().add(SettingsDefaultSettingsRestored()),
            icon: const Icon(Icons.restore),
            tooltip: context.l10n.restoreDefaultSettings,
          ),
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SettingsStatus.updatingSucceeded) {
            _handleSaveSuccess(context);
          }
          if (state.status == SettingsStatus.updatingFailure) {
            _handleSaveFailure(context);
          }
        },
        child: const SettingsContent(),
      ),
    );
  }

  void _handleSaveFailure(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const Key('setting_saveFailure_snackBar'),
          content: Text(
            context.l10n.saveFailure,
          ),
        ),
      );
  }

  void _handleSaveSuccess(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const Key('setting_saveSuccess_snackBar'),
          content: Text(
            context.l10n.saveSucceeded,
          ),
        ),
      );
  }
}
