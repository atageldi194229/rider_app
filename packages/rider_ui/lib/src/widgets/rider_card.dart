import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UICard extends StatelessWidget {
  const UICard({
    super.key,
    this.child,
    this.borderRadius,
    this.border,
    this.padding,
    this.color,
    this.disabled = false,
    this.onTap,
  });

  final Widget? child;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsets? padding;
  final Color? color;
  final bool? disabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final lighBoxShadow = [
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 3,
      ),
    ];

    final borderRadius = this.borderRadius ?? BorderRadius.circular(UISpacing.xs);

    Widget card = Container(
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        // Border.all(
        //   color: theme.colorScheme.outlineVariant,
        // ),
        color: color ?? theme.colorScheme.onSecondary,
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 4.0,
        //     color: Colors.black.withOpacity(0.15),
        //   ),
        // ],
        boxShadow: theme.brightness == Brightness.light ? lighBoxShadow : kElevationToShadow[1],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );

    if (disabled == true) {
      card = Opacity(
        opacity: 0.5,
        child: AbsorbPointer(
          absorbing: true,
          child: card,
        ),
      );
    }

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
