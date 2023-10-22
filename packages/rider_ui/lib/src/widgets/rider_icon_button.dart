import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UIIconButton extends StatelessWidget {
  const UIIconButton({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.tooltip,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(UISpacing.xs),
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        padding: padding,
        icon: child,
      ),
    );
  }
}
