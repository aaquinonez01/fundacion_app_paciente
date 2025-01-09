import 'package:formz/formz.dart';

enum DateError { empty, format }

class Date extends FormzInput<String, DateError> {
  static final RegExp dateRegExp = RegExp(
    r'^\d{2}\/\d{2}\/\d{4}$',
  );

  const Date.pure() : super.pure('');
  const Date.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DateError.empty) return 'El campo es requerido';
    if (displayError == DateError.format) {
      return 'No tiene formato de fecha';
    }

    return null;
  }

  @override
  DateError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DateError.empty;
    if (!dateRegExp.hasMatch(value)) return DateError.format;

    return null;
  }
}
