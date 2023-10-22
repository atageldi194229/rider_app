import 'package:asman_rider/network_error/network_error.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderLinesContent extends StatelessWidget {
  const OrderLinesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((OrderLinesBloc bloc) => bloc.state.status);
    final orderLines = context.select((OrderLinesBloc bloc) => bloc.state.orderLines);
    final isEditableMode = context.select((OrderLinesBloc bloc) => bloc.mode == OrderLinesMode.editable);

    if (status == OrderLinesStatus.failure) {
      return NetworkError(
        onRetry: () => context.read<OrderLinesBloc>().add(OrderLinesRequested()),
      );
    }

    if (status == OrderLinesStatus.loading || status == OrderLinesStatus.initial) {
      return const UILoader();
    }

    if (orderLines != null) {
      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<OrderLinesBloc>().add(OrderLinesRequested());
              },
              child: OrderLinesListView(orderLines: orderLines),
            ),
          ),
          if (isEditableMode) OrderLinesCompleteAction(orderLines: orderLines),
        ],
      );
    }

    return const SizedBox();
  }
}

class OrderLinesListView extends StatelessWidget {
  const OrderLinesListView({
    super.key,
    required this.orderLines,
  });

  final OrderLines orderLines;

  @override
  Widget build(BuildContext context) {
    final lines = orderLines.lines;
    final itemCount = (lines?.length ?? 0);

    return ListView.separated(
      padding: const EdgeInsets.all(UISpacing.md),
      itemCount: itemCount + 1,
      separatorBuilder: (_, __) => const SizedBox(height: UISpacing.md),
      itemBuilder: (context, index) {
        // if item is last
        if (itemCount == index) {
          final attributes = orderLines.attributes?.map((e) => (e.name, e.value?.toString()));

          // if attributes is empty show nothing
          if (attributes == null || attributes.isEmpty) {
            return const SizedBox();
          }

          // Attributes container
          return UIDataAttributes(
            attributes: attributes,
          );
        }

        // Order line item card
        return OrderLinesItemCard(
          line: lines![index],
        );
      },
    );
  }
}
