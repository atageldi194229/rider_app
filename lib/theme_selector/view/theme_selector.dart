import 'package:asman_rider/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A drop down menu to select a new [ThemeMode]
///
/// Requires a [ThemeModeBloc] to be provided in the widget tree
/// (usually above [MaterialApp])
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    var themeMode = context.watch<ThemeModeBloc>().state;
    final theme = Theme.of(context);

    if (themeMode == ThemeMode.system) {
      themeMode = theme.colorScheme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    if (themeMode == ThemeMode.light) {
      return IconButton(
        onPressed: () => context.read<ThemeModeBloc>().add(const ThemeModeChanged(ThemeMode.dark)),
        icon: const Icon(Icons.dark_mode),
      );
    }

    return IconButton(
      onPressed: () => context.read<ThemeModeBloc>().add(const ThemeModeChanged(ThemeMode.light)),
      icon: const Icon(Icons.light_mode),
    );
  }
}
