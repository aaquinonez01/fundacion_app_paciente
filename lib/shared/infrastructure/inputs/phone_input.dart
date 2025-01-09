import 'package:formz/formz.dart';

// Phone Field
enum PhoneError { empty, invalid }

class Phone extends FormzInput<String, PhoneError> {
  static final RegExp phoneRegExp = RegExp(r'^\+?[0-9]{10,13}$');

  const Phone.pure() : super.pure('');
  const Phone.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == PhoneError.empty) return 'El campo es requerido';
    if (displayError == PhoneError.invalid) return 'Número inválido';
    return null;
  }

  @override
  PhoneError? validator(String value) {
    if (value.isEmpty) return PhoneError.empty;
    if (!phoneRegExp.hasMatch(value)) return PhoneError.invalid;
    return null;
  }
}
