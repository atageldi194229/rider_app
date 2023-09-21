import 'package:asman_rider/authentication/authentication.dart';
import 'package:asman_rider/history/history.dart';
import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/reports/reports.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  // static const _contentPadding = UISpacing.lg;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const NavDrawerHeader(),
          ListTile(
            onTap: () => Navigator.of(context).push(HistoryPage.route()),
            style: ListTileStyle.drawer,
            title: Text(context.l10n.history),
            leading: const Icon(Icons.history_rounded),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(ReportsPage.route()),
            style: ListTileStyle.drawer,
            title: Text(context.l10n.reports),
            leading: const Icon(Icons.list_alt_rounded),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(SettingsPage.route()),
            style: ListTileStyle.drawer,
            title: Text(context.l10n.settings),
            leading: const Icon(Icons.settings_rounded),
          ),
          ListTile(
            onTap: () => context.read<AuthenticationBloc>().add(const AuthenticationLogoutRequested()),
            style: ListTileStyle.drawer,
            title: Text(context.l10n.logout),
            leading: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}
