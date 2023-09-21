import 'package:asman_rider/profile/profile.dart';
import 'package:asman_rider/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider_ui/rider_ui.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final user = context.select((ProfileBloc bloc) => bloc.state.riderState);

    return DrawerHeader(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(UISpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // User info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text("+${user?.phone}")),
                      Expanded(child: Text("#${user?.id} ${user?.firstname} ${user?.lastname}")),
                      Expanded(child: Text("#${user?.warehouseId} ${user?.warehouseName}")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const ThemeSelector(),
        ],
      ),
    );
  }
}
