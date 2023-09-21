part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final Phone phone;
  final Password password;
  final FormzSubmissionStatus status;

  bool get isValid => Formz.validate([phone, password]);
  bool get isLoginStartable => isValid && status != FormzSubmissionStatus.inProgress;

  @override
  List<Object> get props => [phone, password, status, isValid];

  LoginState copyWith({
    Phone? phone,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
