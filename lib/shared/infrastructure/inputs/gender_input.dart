import 'package:formz/formz.dart';

enum GenderError { empty }

//El campo esta vacil si esta seleccionado "genero"
class Gender extends FormzInput<String, GenderError> {
  const Gender.pure() : super.pure('');
  const Gender.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == GenderError.empty) return 'El campo es requerido';
    return null;
  }

  @override
  GenderError? validator(String value) {
    if (value.isEmpty) return GenderError.empty;
    return null;
  }
}
