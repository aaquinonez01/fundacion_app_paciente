import 'package:formz/formz.dart';

// Address Field
enum AddressError { empty }

class Address extends FormzInput<String, AddressError> {
  const Address.pure() : super.pure('');
  const Address.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == AddressError.empty) return 'El campo es requerido';
    return null;
  }

  @override
  AddressError? validator(String value) {
    if (value.isEmpty) return AddressError.empty;
    return null;
  }
}
