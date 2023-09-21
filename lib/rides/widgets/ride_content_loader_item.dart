import 'package:flutter/material.dart';
import 'package:rider_ui/rider_ui.dart';

/// Renders a widget containing a progress indicator that calls
/// [onPresented] when the item becomes visible.
class RideContentLoaderItem extends StatefulWidget {
  const RideContentLoaderItem({super.key, this.onPresented});

  /// A callback performed when the widget is presented.
  final VoidCallback? onPresented;

  @override
  State<RideContentLoaderItem> createState() => _RideContentLoaderItemState();
}

class _RideContentLoaderItemState extends State<RideContentLoaderItem> {
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
