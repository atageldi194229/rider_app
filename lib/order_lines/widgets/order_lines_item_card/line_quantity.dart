part of 'order_lines_item_card.dart';

class _LineCount extends StatelessWidget {
  const _LineCount({
    required this.line,
  });

  final Line line;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditableMode = context.select((OrderLinesBloc bloc) => bloc.mode == OrderLinesMode.editable);

    return Container(
      margin: const EdgeInsets.all(UISpacing.md),
      decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: IntrinsicWidth(
        child: Column(
          children: [
            /// Decrement Button
            if (isEditableMode) ...[
              _LineQuantityUpdateButton(
                enabled: line.quantity != 0,
                line: line,
                iconData: Icons.remove,
                onTap: () => context.read<OrderLinesBloc>().add(OrderLinesItemDecremented(line.id!)),
              ),
              // IntrinsicHeight(child: const Divider(height: 1)),
              const Divider(height: 1),
            ],

            /// Line returned count and quantity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: UISpacing.sm, vertical: UISpacing.sm),
              child: Text("${line.returned}/${line.quantity}", style: theme.textTheme.labelLarge),
            ),

            /// Increment button
            if (isEditableMode) ...[
              const Divider(height: 1),
              _LineQuantityUpdateButton(
                enabled: line.returned != 0,
                line: line,
                iconData: Icons.add,
                onTap: () => context.read<OrderLinesBloc>().add(OrderLinesItemIncremented(line.id!)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LineQuantityUpdateButton extends StatelessWidget {
  const _LineQuantityUpdateButton({
    required this.line,
    required this.iconData,
    required this.onTap,
    this.enabled = true,
  });

  final Line line;
  final IconData iconData;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isActionEnabled = context.select(
      (OrderLinesBloc bloc) => !(bloc.state.updatingLineId == line.id && bloc.state.status == OrderLinesStatus.updatingItemQuantity),
    );

    bool isButtonEnabled = isActionEnabled && enabled;

    return InkWell(
      onTap: isButtonEnabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.sm),
        child: Icon(iconData, color: isButtonEnabled ? null : Colors.grey),
      ),
    );
  }
}
