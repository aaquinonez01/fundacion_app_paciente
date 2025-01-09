import 'package:formz/formz.dart';

enum LastnameError { empty, tooShort }

class Lastname extends FormzInput<String, LastnameError> {
  const Lastname.pure() : super.pure('');
  const Lastname.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == LastnameError.empty) return 'El campo es requerido';
    if (displayError == LastnameError.tooShort) {
      return 'Debe tener al menos 3 caracteres';
    }
    return null;
  }

  @override
  LastnameError? validator(String value) {
    if (value.isEmpty) return LastnameError.empty;
    if (value.length < 3) return LastnameError.tooShort;
    return null;
  }
}
