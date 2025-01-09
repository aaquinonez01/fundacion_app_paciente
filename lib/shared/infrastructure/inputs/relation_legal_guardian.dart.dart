import 'package:formz/formz.dart';

enum RelationLegalGuardianError { empty, invalid }

const typesRelationLegalGuardian = [
  'PADRE',
  'MADRE',
  'ABUELO',
  'ABUELA',
  'TIO',
  'TIA',
  'HERMANO',
  'HERMANA',
  'GUARDIAN LEGAL'
];

class RelationLegalGuardian
    extends FormzInput<String, RelationLegalGuardianError> {
  const RelationLegalGuardian.pure() : super.pure('');
  const RelationLegalGuardian.dirty([String value = '']) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (error == RelationLegalGuardianError.empty)
      return 'El campo es requerido';
    if (error == RelationLegalGuardianError.invalid)
      return 'El valor no es válido';

    return null;
  }

  @override
  RelationLegalGuardianError? validator(String value) {
    print("Relacion " + value);
    if (value.isEmpty || value.trim().isEmpty)
      return RelationLegalGuardianError.empty;
    if (!typesRelationLegalGuardian.contains(value))
      return RelationLegalGuardianError.invalid;

    return null;
  }
}
