import 'package:asman_rider/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

/// {@template network_error}
/// A network error alert.
/// {@endtemplate}
class NetworkError extends StatelessWidget {
  /// {@macro network_error}
  const NetworkError({super.key, this.onRetry});

  /// An optional callback which is invoked when the retry button is pressed.
  final VoidCallback? onRetry;

  /// Route constructor to display the widget inside a [Scaffold].
  static Route<void> route({VoidCallback? onRetry}) {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: NetworkError(onRetry: onRetry),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: UISpacing.xlg),
        Icon(
          Icons.error_outline,
          size: 80,
          color: theme.colorScheme.error,
        ),
        const SizedBox(height: UISpacing.lg),
        Text(
          l10n.networkError,
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: UISpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UISpacing.xxxlg),
          child: UIButton.darkAqua(
            onPressed: onRetry,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 0,
                  child: Icon(Icons.refresh, size: UITextStyle.button.fontSize),
                ),
                const SizedBox(width: UISpacing.xs),
                Flexible(
                  child: Text(
                    l10n.networkErrorButton,
                    style: UITextStyle.button,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: UISpacing.xlg),
      ],
    );
  }
}
