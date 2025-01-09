import 'package:formz/formz.dart';

// Username Field
enum UsernameError { empty, tooShort }

class Username extends FormzInput<String, UsernameError> {
  const Username.pure() : super.pure('');
  const Username.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.tooShort) {
      return 'Debe tener al menos 3 caracteres';
    }
    return null;
  }

  @override
  UsernameError? validator(String value) {
    if (value.isEmpty) return UsernameError.empty;
    if (value.length < 3) return UsernameError.tooShort;
    return null;
  }
}
