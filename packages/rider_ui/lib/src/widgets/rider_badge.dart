import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UIBadge extends StatelessWidget {
  const UIBadge({
    super.key,
    this.labelText,
    this.backgroundColor,
    this.color,
  });

  final String? labelText;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (labelText == null) return const SizedBox();

    return Material(
      // padding: const EdgeInsets.all(UISpacing.md),
      borderRadius: BorderRadius.circular(UISpacing.xs),
      color: backgroundColor ?? const Color.fromARGB(25, 247, 184, 75),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: UISpacing.xs, horizontal: UISpacing.sm),
        child: Text(
          labelText!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: color ?? const Color(0xFFF7B84B),
          ),
        ),
      ),
    );
  }
}
