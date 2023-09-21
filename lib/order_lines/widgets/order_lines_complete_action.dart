import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/order_lines/order_lines.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class OrderLinesCompleteAction extends StatelessWidget {
  const OrderLinesCompleteAction({super.key, required this.orderLines});

  final OrderLines orderLines;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(UISpacing.md);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(UISpacing.lg),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(radius),
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
          ),
          color: theme.colorScheme.surface,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(radius),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: theme.colorScheme.primary,
                  child: InkWell(
                    onTap: () {
                      showDialog<RidePointCompleteRequest>(
                        context: context,
                        builder: (_) => OrderPayDialog(orderLines: orderLines),
                      ).then((data) {
                        if (data != null) {
                          context.read<OrderLinesBloc>().add(OrderLinesPointComplete(
                                payMethod: data.payMethod!,
                                cashPayed: data.cashPayed!,
                                cardPayed: data.cardPayed!,
                                terminalCode: data.terminalCode!,
                              ));
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: UISpacing.lg),
                      child: Center(
                        child: Text(
                          context.l10n.complete,
                          style: TextStyle(color: theme.colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(child: Text("${orderLines.totalText}")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
