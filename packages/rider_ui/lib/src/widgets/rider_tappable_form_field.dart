import 'package:flutter/material.dart';

class UITappableFormField extends StatelessWidget {
  const UITappableFormField({
    super.key,
    this.value,
    this.labelText = "",
    this.onTap,
    this.leading,
    this.errorText,
  });

  final String? value;
  final String labelText;
  final VoidCallback? onTap;
  final Widget? leading;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    String value = this.labelText;
    String? labelText;

    if (this.value != null) {
      labelText = value;
      value = this.value!;
    }

    return InkWell(
      onTap: onTap,
      child: Ink(
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: leading,
            errorText: errorText,
          ),
          child: Text(value),
        ),
      ),
    );
  }
}
