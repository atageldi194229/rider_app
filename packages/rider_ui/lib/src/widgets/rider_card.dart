import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UICard extends StatelessWidget {
  const UICard({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const radius = Radius.circular(UISpacing.md);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // color: theme.cardTheme.color ??theme.cardColor,
        borderRadius: const BorderRadius.all(radius),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
        color: theme.colorScheme.surface,
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 4.0,
        //     color: Colors.black.withOpacity(0.15),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(radius),
        child: child,
      ),
    );
  }
}
