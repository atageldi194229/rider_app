import 'package:flutter/material.dart';

class UIDataRow extends StatelessWidget {
  const UIDataRow(this.keyText, this.valueText, {super.key});

  final String keyText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(keyText, style: theme.textTheme.titleMedium),
        Expanded(
          child: Text(
            " . " * 150,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ),
        Text(valueText, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
