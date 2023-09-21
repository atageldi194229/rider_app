import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:rider_ui/rider_ui.dart';

class BaseUrlField extends StatelessWidget {
  const BaseUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    final baseUrl = context.select((SettingsBloc bloc) => bloc.state.baseUrl);

    final labelText = context.l10n.baseURL;

    return ListTile(
      onTap: () {
        UtilDialog.showTextFieldDialog(
          context: context,
          onSuccess: (value) async {
            context.read<SettingsBloc>().add(SettingsBaseUrlChanged(value));
          },
          validator: (value) => switch (baseUrl.validator(value ?? '')) {
            BaseUrlValidationError.empty => 'empty',
            BaseUrlValidationError.invalid => 'url_is_not_valid',
            _ => null,
          },
          initialValue: baseUrl.value,
          labelText: labelText,
        );
      },
      title: Text(labelText),
      subtitle: Text(baseUrl.value),
    );
  }
}
