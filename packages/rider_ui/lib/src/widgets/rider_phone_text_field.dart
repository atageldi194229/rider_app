import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

/// {@template app_phone_text_field}
/// A phone text field component.
/// {@endtemplate}
class UIPhoneTextField extends StatelessWidget {
  /// {@macro app_phone_text_field}
  const UIPhoneTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.suffix,
    this.readOnly,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text input label text
  final String? labelText;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// When user done editing
  final ValueChanged<String>? onSubmitted;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool? readOnly;

  /// Input error message
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return UITextField(
      labelText: labelText,
      controller: controller,
      readOnly: readOnly,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      maxLength: 8,
      autoFillHints: const [AutofillHints.telephoneNumber],
      autocorrect: false,
      prefix: Padding(
        padding: const EdgeInsets.all(0).copyWith(
          left: UISpacing.sm,
          right: UISpacing.sm,
        ),
        child: const Icon(Icons.phone_outlined),
      ),
      prefixText: '+993',
      onChanged: onChanged,
      suffix: suffix,
      errorText: errorText,
      onSubmitted: onSubmitted,
    );
  }
}
