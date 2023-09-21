import 'package:asman_rider/l10n/l10n.dart';
import 'package:asman_rider/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:rider_ui/rider_ui.dart';

part 'login_form_fields.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(context.l10n.loginFailure)),
                );
            }
          },
        ),
      ],
      child: const _LoginContent(),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: UILoginPageBackground(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                UISpacing.xlg,
                UISpacing.lg,
                UISpacing.xlg,
                UISpacing.xxlg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: UISpacing.xxlg),
                  _PhoneInput(),
                  SizedBox(height: UISpacing.xs),
                  _PasswordInput(),
                  SizedBox(height: UISpacing.sm),
                  _LoginButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
