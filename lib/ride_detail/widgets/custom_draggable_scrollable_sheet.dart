import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

@immutable
class CustomDraggableScrollableSheet extends StatelessWidget {
  const CustomDraggableScrollableSheet({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.1,
      builder: (context, scrollController) {
        return Card(
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const _DragStick(),
                if (child != null) child!,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DragStick extends StatelessWidget {
  const _DragStick();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.inverseSurface.withOpacity(0.4);
    const dividend = 3;
    const divisor = 10;

    return Padding(
      padding: const EdgeInsets.all(UISpacing.xs),
      child: Row(
        children: [
          const Spacer(flex: divisor),
          Expanded(
            flex: dividend,
            child: Card(
              elevation: 0,
              color: color,
              child: const SizedBox(height: UISpacing.xs),
            ),
          ),
          const Spacer(flex: divisor),
        ],
      ),
    );
  }
}
