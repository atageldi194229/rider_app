import 'package:asman_rider/authentication/authentication.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select((AuthenticationBloc bloc) => bloc.state.status == AuthenticationStatus.authenticated);

    return ListView(
      children: [
        /// Base URL
        const BaseUrlField(),
        const Divider(),

        /// Language
        const LanguageField(),

        /// Password
        if (isAuthenticated) ...[
          const Divider(),
          const PasswordField(),
        ],
      ],
    );
  }
}
