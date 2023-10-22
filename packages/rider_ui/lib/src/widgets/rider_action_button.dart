import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:slide_action/slide_action.dart';

class UIActionButton extends StatelessWidget {
  const UIActionButton({
    this.action,
    this.text,
    super.key,
  });

  final FutureOr<void> Function()? action;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// Try to use slide_to_act
    return SlideAction(
      trackBuilder: (context, state) {
        return Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(UISpacing.sm),
          ),
          child: Center(
            child: Text(
              // Show loading if async operation is being performed
              // state.isPerformingAction ? "Loading..." : "$text",
              "$text",
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(UISpacing.xs),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(UISpacing.xs),
          ),
          child: Center(
            // Show loading indicator if async operation is being performed
            child: state.isPerformingAction
                ? const CupertinoActivityIndicator(color: Colors.white)
                : const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
          ),
        );
      },
      action: () async {
        await action?.call();
      },
    );
  }
}
