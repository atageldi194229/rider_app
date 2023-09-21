import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

@immutable
class UILoader extends StatelessWidget {
  const UILoader({this.color, this.size, this.padding, super.key});

  final Color? color;
  final double? size;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(UISpacing.lg),
      child: SizedBox(
        height: size,
        width: size,
        child: Center(
          child: CircularProgressIndicator(color: color),
        ),
      ),
    );
  }
}
