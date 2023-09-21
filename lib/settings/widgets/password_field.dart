import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:rider_ui/rider_ui.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final password = context.select((SettingsBloc bloc) => bloc.state.password);

    final labelText = context.l10n.password;

    return ListTile(
      onTap: () {
        UtilDialog.showTextFieldDialog(
          context: context,
          onSuccess: (value) async {
            context.read<SettingsBloc>().add(SettingsPasswordChanged(value));
          },
          validator: (value) => switch (password.validator(value ?? '')) {
            PasswordValidationError.empty => 'empty',
            // PasswordValidationError.invalid => 'url_is_not_valid',
            _ => null,
          },
          labelText: labelText,
        );
      },
      title: Text(labelText),
      subtitle: const Text("***"),
    );
  }
}
