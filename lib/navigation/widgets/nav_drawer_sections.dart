import 'package:asman_rider/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final user = context.select((ProfileBloc bloc) => bloc.state.riderState);

    return Padding(
      padding: const EdgeInsets.all(UISpacing.lg).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("+${user?.phone}"),
          const SizedBox(height: UISpacing.lg),
          Text("${user?.id} - ${user?.firstname} ${user?.lastname}"),
          const SizedBox(height: UISpacing.lg),
          Text("${user?.warehouseId} - ${user?.warehouseName}"),
          const SizedBox(height: UISpacing.lg),
          const Divider(),
        ],
      ),
    );
  }
}
