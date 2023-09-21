import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

/// Renders a widget containing a progress indicator that calls
/// [onPresented] when the item becomes visible.
class HistoryContentLoaderItem extends StatefulWidget {
  const HistoryContentLoaderItem({super.key, this.onPresented});

  /// A callback performed when the widget is presented.
  final VoidCallback? onPresented;

  @override
  State<HistoryContentLoaderItem> createState() => _HistoryContentLoaderItemState();
}

class _HistoryContentLoaderItemState extends State<HistoryContentLoaderItem> {
  @override
  void initState() {
    super.initState();
    widget.onPresented?.call();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: UISpacing.lg),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
