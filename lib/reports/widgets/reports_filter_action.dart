import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_ui/rider_ui.dart';

/// Result callback, which is sends filter data
typedef ResultCallback = Function(ReportsFilter filter);

class ReportsFilterAction extends StatefulWidget {
  const ReportsFilterAction({
    super.key,
    this.onDone,
    this.onReset,
  });

  final ResultCallback? onDone;
  final VoidCallback? onReset;

  @override
  State<ReportsFilterAction> createState() => _ReportsFilterActionState();
}

class _ReportsFilterActionState extends State<ReportsFilterAction> {
  ValueNotifier<String?> fromTimeError = ValueNotifier(null);
  ValueNotifier<String?> toTimeError = ValueNotifier(null);

  ValueNotifier<DateTime?> fromTime = ValueNotifier(null);
  ValueNotifier<DateTime?> toTime = ValueNotifier(null);

  @override
  dispose() {
    fromTimeError.dispose();
    toTimeError.dispose();
    fromTime.dispose();
    toTime.dispose();
    super.dispose();
  }

  _showDatePicker(BuildContext context, ValueNotifier<DateTime?> notifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: notifier.value ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != notifier.value) {
      notifier.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: _buildModal,
        );
      },
      icon: const Icon(Icons.filter_alt_outlined),
    );
  }

  Widget _buildModal(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(UISpacing.lg).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + UISpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: fromTimeError,
              builder: (context, error, _) {
                return ValueListenableBuilder(
                  valueListenable: fromTime,
                  builder: (context, date, child) => UITappableFormField(
                    onTap: () => _showDatePicker(context, fromTime),
                    labelText: context.l10n.from,
                    leading: const Icon(Icons.calendar_month),
                    value: _getFormattedDate(date),
                    errorText: error,
                  ),
                );
              },
            ),
            const SizedBox(height: UISpacing.lg),
            ValueListenableBuilder(
              valueListenable: toTimeError,
              builder: (_, error, __) {
                return ValueListenableBuilder(
                  valueListenable: toTime,
                  builder: (context, date, child) => UITappableFormField(
                    onTap: () => _showDatePicker(context, toTime),
                    labelText: context.l10n.to,
                    leading: const Icon(Icons.calendar_month),
                    value: _getFormattedDate(date),
                    errorText: error,
                  ),
                );
              },
            ),
            const SizedBox(height: UISpacing.lg),
            Row(
              children: [
                const Spacer(),
                _resetButton(context),
                const SizedBox(width: UISpacing.sm),
                _submitButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextButton _resetButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        fromTime.value = null;
        fromTimeError.value = null;

        toTimeError.value = null;
        toTime.value = null;

        widget.onReset?.call();
        Navigator.of(context).pop();
      },
      child: Text(context.l10n.reset),
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // if ((fromTime.value, toTime.value) != (null, null)) {
        //   fromTimeError.value = fromTime.value == null ? "empty".tr(context) : null;
        //   toTimeError.value = toTime.value == null ? "empty".tr(context) : null;
        // }

        widget.onDone?.call(
          ReportsFilter(
            fromTime: fromTime.value,
            toTime: toTime.value,
          ),
        );

        Navigator.of(context).pop();

        // if ((fromTimeError.value, toTimeError.value) == (null, null)) {
        //   widget.onDone?.call(FilterModel(
        //     fromTime: fromTime.value,
        //     toTime: toTime.value,
        //     orderId: int.tryParse(orderIdController.text),
        //   ));
        //   Navigator.of(context).pop();
        // }
      },
      child: Text(context.l10n.ok),
    );
  }

  String? _getFormattedDate(DateTime? date) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return date == null ? null : dateFormat.format(date);
  }
}
