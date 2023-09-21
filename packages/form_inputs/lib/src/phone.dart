import 'package:formz/formz.dart';

/// Phone Form Input Validation Error
enum PhoneValidationError {
  /// If phone is empty
  empty,

  /// Phone is invalid (generic validation error)
  invalid
}

/// {@template phone}
/// Reusable phone form input.
/// {@endtemplate}
class Phone extends FormzInput<String, PhoneValidationError> {
  /// {@macro phone}
  const Phone.pure() : super.pure('');

  /// {@macro phone}
  const Phone.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(r'^9936\d{7}$');

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) return PhoneValidationError.empty;
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}
