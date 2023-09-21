import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

part 'line_updating_indicator.dart';
part 'line_quantity.dart';
part 'line_image.dart';

class OrderLinesItemCard extends StatelessWidget {
  const OrderLinesItemCard({
    super.key,
    required this.line,
  });

  final Line line;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return UICard(
      child: Column(
        children: [
          Row(
            children: [
              LineImage(lineImage: line.product!.thumbPic!),
              const SizedBox(width: UISpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#${line.id}", style: theme.textTheme.labelMedium, overflow: TextOverflow.ellipsis),
                    Text("${line.product!.shortName}", overflow: TextOverflow.ellipsis),
                    Text("${line.totalText}", style: theme.textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              _LineCount(line: line),
              // const SizedBox(width: UISpacing.md),
            ],
          ),
          OrderLinesQuantityUpdatingIndicator(line: line),
        ],
      ),
    );
  }
}
