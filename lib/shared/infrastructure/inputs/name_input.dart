import 'package:formz/formz.dart';

enum NameError { empty, tooShort }

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');
  const Name.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.tooShort) {
      return 'Debe tener al menos 3 caracteres';
    }
    return null;
  }

  @override
  NameError? validator(String value) {
    if (value.isEmpty) return NameError.empty;
    if (value.length < 3) return NameError.tooShort;
    return null;
  }
}
