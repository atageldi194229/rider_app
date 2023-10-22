part of 'login_form.dart';

/// Phone number input
class _PhoneInput extends StatefulWidget {
  const _PhoneInput();

  @override
  State<_PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<_PhoneInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      final phone = _controller.text;
      context.read<LoginBloc>().add(LoginPhoneChanged("993$phone"));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<LoginBloc>().state;

    return UIPhoneTextField(
      key: const Key('loginForm_phoneInput_textField'),
      controller: _controller,
      labelText: l10n.phone,
      readOnly: state.status.isInProgress,
      suffix: ClearIconButton(
        isVisible: context.select((LoginBloc bloc) => bloc.state.phone.value.isNotEmpty),
        onPressed: !state.status.isInProgress
            ? () {
                _controller.clear();
                context.read<LoginBloc>().add(const LoginPhoneChanged(''));
              }
            : null,
      ),
      // errorText: switch (state.phone.displayError) {
      //   PhoneValidationError.empty => 'empty',
      //   PhoneValidationError.invalid => 'invalid',
      //   _ => null,
      // },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Password input field
class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      final password = _controller.text;
      context.read<LoginBloc>().add(LoginPasswordChanged(password));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return UIPasswordTextField(
      key: const Key('loginForm_passwordInput_textField'),
      controller: _controller,
      labelText: context.l10n.password,
      readOnly: state.status.isInProgress,
      suffix: ClearIconButton(
        isVisible: context.select((LoginBloc bloc) => bloc.state.password.value.isNotEmpty),
        onPressed: !state.status.isInProgress
            ? () {
                _controller.clear();
                context.read<LoginBloc>().add(const LoginPasswordChanged(''));
              }
            : null,
      ),
      // errorText: switch (state.password.displayError) {
      //   PasswordValidationError.empty => 'empty',
      //   _ => null,
      // },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Login button
class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<LoginBloc>().state;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onSecondary),
      key: const Key('loginForm_loginButton'),
      onPressed: state.isValid ? () => context.read<LoginBloc>().add(LoginStarted()) : null,
      child: state.status.isInProgress
          ? const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(
                  // color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            )
          : Text(l10n.login),
    );
  }
}

/// Clear icon button for input suffix
@visibleForTesting
class ClearIconButton extends StatelessWidget {
  const ClearIconButton({
    required this.onPressed,
    this.isVisible = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('loginWithEmailForm_clearIconButton'),
      padding: const EdgeInsets.only(right: UISpacing.md),
      child: Visibility(
        visible: isVisible,
        child: GestureDetector(
          onTap: onPressed,
          child: const Icon(
            Icons.close_rounded,
            size: UISpacing.spaceUnit,
          ),
        ),
      ),
    );
  }
}
