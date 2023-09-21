import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asman_rider/navigation/navigation.dart';
import 'package:asman_rider/navigation/widgets/line_status_action.dart';

class NavAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NavAppBar({this.title, super.key});

  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LineStatusBloc(
        lineStatusRepository: context.read<LineStatusRepository>(),
      )..add(LineStatusStarted()),
      child: AppBar(
        title: title ?? const Text("Asman Rider"),
        actions: const [
          LineStatusAction(),
        ],
      ),
    );
  }
}
