import 'package:formz/formz.dart';

/// number Form Input Validation Error
enum NumberValidationError {
  /// If the number is empty
  empty,

  /// If it is not number
  notNumber,
}

/// {@template number}
/// Reusable number form input.
/// {@endtemplate}
class Number extends FormzInput<String, NumberValidationError> {
  /// {@macro number}
  const Number.pure() : super.pure('');

  /// {@macro number}
  const Number.dirty([super.value = '']) : super.dirty();

  @override
  NumberValidationError? validator(String value) {
    if (value.isNotEmpty) {
      return NumberValidationError.empty;
    }

    if (num.tryParse(value) == null) {
      return NumberValidationError.notNumber;
    }

    return null;
  }
}
