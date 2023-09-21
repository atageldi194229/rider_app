import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageField extends StatefulWidget {
  const LanguageField({super.key});

  @override
  State<LanguageField> createState() => _LanguageFieldState();
}

class _LanguageFieldState extends State<LanguageField> {
  /// This is the global key, which will be used to traverse [DropdownButton]s widget tree
  final GlobalKey _dropdownButtonKey = GlobalKey();

  /// When ListTile is tapped, the dropdown is opened
  void openDropdown() {
    _dropdownButtonKey.currentContext?.visitChildElements((element) {
      if (element.widget is Semantics) {
        element.visitChildElements((element) {
          if (element.widget is Actions) {
            element.visitChildElements((element) {
              Actions.invoke(element, const ActivateIntent());
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageTextWidget = Text(context.l10n.language);

    final locale = context.select((LanguageBloc bloc) => bloc.state);

    return ListTile(
      onTap: openDropdown,
      title: languageTextWidget,
      subtitle: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          key: _dropdownButtonKey,
          value: locale,
          isExpanded: false,
          isDense: true,
          hint: languageTextWidget,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).textTheme.bodySmall!.color),
          iconSize: 0.0,
          elevation: 6,
          onChanged: (Locale? value) {
            // This is called when the user selects an item.
            if (value != null) {
              context.read<LanguageBloc>().add(LanguageChanged(value));
            }
          },
          items: AppLocalizations.supportedLocales.map((Locale locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(getLocaleReadableText(locale)),
            );
          }).toList(),
        ),
      ),
    );
  }

  String getLocaleReadableText(Locale locale) {
    return switch (locale.languageCode) {
      'tk' => 'Türkmençe',
      'ru' => 'Русский',
      'en' => 'English',
      _ => locale.languageCode,
    };
  }
}
