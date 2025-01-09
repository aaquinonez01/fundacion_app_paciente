import 'package:formz/formz.dart';

enum CedulaError { empty, format }

//La cedula debe tener 10 caracteres
//La cedula no puede estar vacia
//La cedula no puede tener letras ni caracteres especiales
class Cedula extends FormzInput<String, CedulaError> {
  static final RegExp cedulaRegExp = RegExp(
    r'^\d{10}$',
  );

  const Cedula.pure() : super.pure('');
  const Cedula.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CedulaError.empty) return 'El campo es requerido';
    if (displayError == CedulaError.format) {
      return 'No tiene formato de cédula';
    }

    return null;
  }

  @override
  CedulaError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CedulaError.empty;
    if (!cedulaRegExp.hasMatch(value)) return CedulaError.format;

    return null;
  }
}
