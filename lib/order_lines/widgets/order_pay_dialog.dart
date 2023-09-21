import 'package:asman_rider/l10n/l10n.dart';
import 'package:data_provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rider_ui/rider_ui.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class OrderPayDialog extends HookWidget {
  const OrderPayDialog({super.key, required this.orderLines});

  final OrderLines orderLines;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);

    final theme = Theme.of(context);

    const payMethods = ['CASH', 'CARD', 'OTHER'];

    final terminalCodeController = useTextEditingController();
    final cashAmountController = useTextEditingController(text: '0');
    final cardAmountController = useTextEditingController();
    final returnAmountController = useTextEditingController(text: '0');

    final update = useValueListenable(cashAmountController);

    useEffect(() {
      /// Calculate card amount
      double? cashAmount = double.tryParse(cashAmountController.text);

      /// Calculate card amount
      if (cashAmount != null && orderLines.total != null) {
        double cardAmount = orderLines.total! - cashAmount;
        cardAmountController.text = cardAmount.toStringAsFixed(2);
      }

      /// Calculate return amount
      if (cashAmount != null && orderLines.total != null) {
        double returnAmount = cashAmount - orderLines.total!;
        returnAmount = returnAmount > 0 ? returnAmount : 0;
        returnAmountController.text = returnAmount.toStringAsFixed(2);
      }

      return null;
    }, [update]);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom * 1.3),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: UISpacing.lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: UISpacing.xlg),
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(UISpacing.xlg),
                  child: Text(context.l10n.completePayment, style: theme.textTheme.titleLarge),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      controller: tabController,
                      tabs: [
                        Tab(text: context.l10n.cash),
                        Tab(text: context.l10n.card),
                        Tab(text: context.l10n.other),
                      ],
                    ),
                    const SizedBox(height: UISpacing.md),
                    SizedBox(
                      height: 250,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          /// Cash tab
                          Padding(
                            padding: const EdgeInsets.all(UISpacing.xs),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _CashInput(cashAmountController),
                                const SizedBox(height: UISpacing.md),
                                _ReturnInput(returnAmountController),
                              ],
                            ),
                          ),

                          /// Card tab
                          Padding(
                            padding: const EdgeInsets.all(UISpacing.xs),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _TerminalCodeInput(terminalCodeController),
                              ],
                            ),
                          ),

                          /// Other tab
                          Padding(
                            padding: const EdgeInsets.all(UISpacing.xs),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _TerminalCodeInput(terminalCodeController),
                                const SizedBox(height: UISpacing.md),
                                _CashInput(cashAmountController),
                                const SizedBox(height: UISpacing.md),
                                _CardInput(cardAmountController),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(UISpacing.lg),
                  child: ElevatedButton(
                    onPressed: () {
                      final String payMethod = payMethods[tabController.index];
                      final double cashPayed = double.tryParse(cashAmountController.text) ?? 0.0;
                      final double cardPayed = double.tryParse(cardAmountController.text) ?? 0.0;
                      final String terminalCode = terminalCodeController.text;

                      Navigator.of(context).pop(RidePointCompleteRequest(
                        cardPayed: cardPayed,
                        cashPayed: cashPayed,
                        terminalCode: terminalCode,
                        payMethod: payMethod,
                      ));
                    },
                    child: Text(context.l10n.complete),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TerminalCodeInput extends StatelessWidget {
  const _TerminalCodeInput(this.controller);

  final TextEditingController controller;

  void scanBarcode(BuildContext context, Function(String code) onResult) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    ).then((res) {
      if (res != null && res != "null" && res != "-1" && res.toString().isNotEmpty) {
        onResult(res.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: context.l10n.terminalCode,
        suffixIcon: IconButton(
          onPressed: () {
            scanBarcode(
              context,
              (code) => controller.text = code,
            );
          },
          icon: const Icon(Icons.qr_code_scanner_rounded),
        ),
      ),
    );
  }
}

class _CashInput extends StatelessWidget {
  const _CashInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: context.l10n.cashPaymentAmount),
    );
  }
}

class _CardInput extends StatelessWidget {
  const _CardInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: context.l10n.cardPaymentAmount),
    );
  }
}

class _ReturnInput extends StatelessWidget {
  const _ReturnInput(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: context.l10n.cashChangeAmount),
    );
  }
}
