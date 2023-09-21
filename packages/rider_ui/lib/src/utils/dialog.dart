import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UtilDialog {
  /// Shows Diolog with tryAgain button,
  /// if tryAgain button pressed `true` is returned,
  /// if cancel button pressed `false` is returned,
  /// else `null` is returned,
  static Future<bool?> showTryAgainDialog(
    BuildContext context, {
    String title = "title",
    String content = "",
    String tryAgainText = "tryAgain",
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                MaterialLocalizations.of(context).cancelButtonLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                tryAgainText,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showTextDialog(
    BuildContext context, {
    String title = "title",
    String content = "content",
    String? okText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                (okText ?? MaterialLocalizations.of(context).okButtonLabel).toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showTextFieldDialog({
    required BuildContext context,
    void Function(String value)? onSuccess,
    String? initialValue,
    String? labelText,
    String? Function(String?)? validator,
  }) async {
    final formKey = GlobalKey<FormState>();
    String value = initialValue ?? "";

    final errorText = ValueNotifier<String?>(null);

    checkConfirmAvailability(String? v, [isFirstTime = false]) {
      if (validator != null) {
        errorText.value = validator(v);
        // confirmEnabled.value = formKey.currentState?.validate() ?? fa;
        // confirmEnabled.value = validator(v) == null;
      }
    }

    // first time run initialization
    checkConfirmAvailability(initialValue);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(UISpacing.lg),
        content: Row(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ValueListenableBuilder(
                  valueListenable: errorText,
                  builder: (context, error, _) {
                    return TextFormField(
                      autofocus: true,
                      onChanged: (v) {
                        value = v;
                        checkConfirmAvailability(v);
                      },
                      initialValue: initialValue,
                      validator: validator,
                      decoration: InputDecoration(
                        labelText: labelText,
                        errorText: error,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          ValueListenableBuilder(
            valueListenable: errorText,
            builder: (context, error, child) {
              return TextButton(
                onPressed: error != null
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          onSuccess?.call(value);
                        }
                        Navigator.pop(context);
                      },
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
              );
            },
          ),
        ],
      ),
    );
  }
}
