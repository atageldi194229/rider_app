import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

class UIDataAttributes extends StatelessWidget {
  const UIDataAttributes({
    super.key,
    required this.attributes,
    this.nameTextStyle,
    this.valueTextStyle,
    this.padding,
  });

  final Iterable<(String? name, String? value)> attributes;
  final TextStyle? nameTextStyle;
  final TextStyle? valueTextStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final valueTextStyle = this.valueTextStyle ?? const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
    final nameTextStyle = this.nameTextStyle ?? const TextStyle(fontSize: 14.0, color: Colors.grey);

    return UICard(
      padding: padding ?? const EdgeInsets.all(UISpacing.sm),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: attributes.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          final (name, value) = attributes.elementAt(index);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name ?? '', style: nameTextStyle),
              Expanded(
                child: Text(
                  value == null ? '' : value.toString(),
                  style: valueTextStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
