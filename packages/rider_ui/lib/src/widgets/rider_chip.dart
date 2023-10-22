import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UIChip extends StatelessWidget {
  const UIChip({super.key, this.label});

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UISpacing.xs),
        color: const Color(0x99f3f6f9),
      ),
      child: Padding(padding: const EdgeInsets.all(UISpacing.sm), child: label),
    );
  }
}
