part of 'order_lines_item_card.dart';

class OrderLinesQuantityUpdatingIndicator extends StatelessWidget {
  const OrderLinesQuantityUpdatingIndicator({super.key, required this.line});

  final Line line;

  @override
  Widget build(BuildContext context) {
    final isVisible = context.select(
      (OrderLinesBloc bloc) => bloc.state.updatingLineId == line.id && bloc.state.status == OrderLinesStatus.updatingItemQuantity,
    );

    if (isVisible) {
      return const LinearProgressIndicator();
    }

    return const SizedBox();
  }
}
