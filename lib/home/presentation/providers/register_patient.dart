import 'package:formz/formz.dart';

import 'package:fundacion_paciente_app/shared/infrastructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormularioPatientState {
  final Cedula cedula;
  final Name firstname;
  final Lastname lastname;
  final Date date;
  final Gender gender;
  final Name guardian_legal;
  final RelationLegalGuardian relation_legal_guardian;
  final List<String> type_therapy_required;
  final List<String> disabilities;
  final List<String> allergies;
  final List<String> currentMedications;

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  const FormularioPatientState({
    this.cedula = const Cedula.pure(),
    this.firstname = const Name.pure(),
    this.lastname = const Lastname.pure(),
    this.date = const Date.pure(),
    this.gender = const Gender.pure(),
    // ignore: non_constant_identifier_names
    this.guardian_legal = const Name.pure(),
    // ignore: non_constant_identifier_names
    this.relation_legal_guardian = const RelationLegalGuardian.pure(),
    this.disabilities = const [],
    this.allergies = const [],
    this.currentMedications = const [],
    this.type_therapy_required = const [],
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
  });

  FormularioPatientState copyWith({
    Cedula? cedula,
    Name? firstname,
    Lastname? lastname,
    Date? date,
    Gender? gender,
    // ignore: non_constant_identifier_names
    Name? guardian_legal,
    // ignore: non_constant_identifier_names
    RelationLegalGuardian? relation_legal_guardian,
    List<String>? disabilities,
    List<String>? allergies,
    List<String>? currentMedications,
    List<String>? type_therapy_required,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) {
    return FormularioPatientState(
      cedula: cedula ?? this.cedula,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      date: date ?? this.date,
      gender: gender ?? this.gender,
      guardian_legal: guardian_legal ?? this.guardian_legal,
      relation_legal_guardian:
          relation_legal_guardian ?? this.relation_legal_guardian,
      disabilities: disabilities ?? this.disabilities,
      allergies: allergies ?? this.allergies,
      currentMedications: currentMedications ?? this.currentMedications,
      type_therapy_required:
          type_therapy_required ?? this.type_therapy_required,
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
    );
  }
}

class FormularioPatientNotifier extends StateNotifier<FormularioPatientState> {
  FormularioPatientNotifier() : super(const FormularioPatientState());

  void onCedulaChanged(String value) {
    final newCedula = Cedula.dirty(value);
    state = state.copyWith(
      cedula: newCedula,
      isValid: _validateForm(newCedula: newCedula),
    );
  }

  void onFirstnameChanged(String value) {
    final newFirstname = Name.dirty(value);
    state = state.copyWith(
      firstname: newFirstname,
      isValid: _validateForm(newFirstname: newFirstname),
    );
  }

  void onLastnameChanged(String value) {
    final newLastname = Lastname.dirty(value);
    state = state.copyWith(
      lastname: newLastname,
      isValid: _validateForm(newLastname: newLastname),
    );
  }

  void onDateChanged(String value) {
    final newDate = Date.dirty(value);
    state = state.copyWith(
      date: newDate,
      isValid: _validateForm(newDate: newDate),
    );
  }

  void onGenderChanged(String value) {
    final newGender = Gender.dirty(value);
    state = state.copyWith(
        gender: newGender, isValid: _validateForm(newGender: newGender));
  }

  void onGuardianLegalChanged(String value) {
    final newGuardianLegal = Name.dirty(value);
    state = state.copyWith(
      guardian_legal: newGuardianLegal,
      isValid: _validateForm(newGuardianLegal: newGuardianLegal),
    );
  }

  void onRelationLegalGuardianChanged(String value) {
    final newRelationLegalGuardian = RelationLegalGuardian.dirty(value);
    state = state.copyWith(
      relation_legal_guardian: newRelationLegalGuardian,
      isValid:
          _validateForm(newRelationLegalGuardian: newRelationLegalGuardian),
    );
  }

  void onDisabilitiesChanged(List<String> value) {
    state = state.copyWith(disabilities: value);
  }

  void onAllergiesChanged(List<String> value) {
    state = state.copyWith(allergies: value);
  }

  void onTypeTherapyRequiredChanged(List<String> value) {
    state = state.copyWith(type_therapy_required: value);
  }

  void onCurrentMedicationsChanged(List<String> value) {
    print(value);
    state = state.copyWith(currentMedications: value);
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      // Simula un proceso de envío
      await Future.delayed(const Duration(seconds: 2));
      print({
        'cedula': state.cedula.value,
        'firstname': state.firstname.value,
        'lastname': state.lastname.value,
        'date': state.date.value,
        'gender': state.gender.value,
        'guardian_legal': state.guardian_legal.value,
        'relation_legal_guardian': state.relation_legal_guardian.value,
        'disabilities': state.disabilities,
        'allergies': state.allergies,
        'currentMedications': state.currentMedications,
        'type_therapy_required': state.type_therapy_required,
      });
      print('Formulario enviado con éxito');
    } catch (e) {
      print('Error al enviar el formulario: $e');
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  //No permitir que de siguiente si no se ha llenado el formulario parte 1
  void OnNextPage() {
    _touchEveryField();
    if (!state.isValid) return;
  }

  void _touchEveryField() {
    final cedula = Cedula.dirty(state.cedula.value);
    final firstname = Name.dirty(state.firstname.value);
    final lastname = Lastname.dirty(state.lastname.value);
    final date = Date.dirty(state.date.value);
    final gender = Gender.dirty(state.gender.value);
    final guardianLegal = Name.dirty(state.guardian_legal.value);
    final relationLegalGuardian =
        RelationLegalGuardian.dirty(state.relation_legal_guardian.value);
    final disabilities = state.disabilities;
    final allergies = state.allergies;
    final currentMedications = state.currentMedications;
    final typeTherapyRequired = state.type_therapy_required;

    state = state.copyWith(
      isFormPosted: true,
      cedula: cedula,
      firstname: firstname,
      lastname: lastname,
      date: date,
      gender: gender,
      guardian_legal: guardianLegal,
      relation_legal_guardian: relationLegalGuardian,
      disabilities: disabilities,
      allergies: allergies,
      currentMedications: currentMedications,
      type_therapy_required: typeTherapyRequired,
      isValid: _validateForm(
        newCedula: cedula,
        newFirstname: firstname,
        newLastname: lastname,
        newDate: date,
        newGender: gender,
        newGuardianLegal: guardianLegal,
        newRelationLegalGuardian: relationLegalGuardian,
      ),
    );
  }

  bool _validateForm({
    Cedula? newCedula,
    Name? newFirstname,
    Lastname? newLastname,
    Date? newDate,
    Gender? newGender,
    Name? newGuardianLegal,
    RelationLegalGuardian? newRelationLegalGuardian,
  }) {
    return Formz.validate([
      newCedula ?? state.cedula,
      newFirstname ?? state.firstname,
      newLastname ?? state.lastname,
      newDate ?? state.date,
      newGender ?? state.gender,
      newGuardianLegal ?? state.guardian_legal,
      newRelationLegalGuardian ?? state.relation_legal_guardian,
    ]);
  }
}

final registerPatientProvider =
    StateNotifierProvider<FormularioPatientNotifier, FormularioPatientState>(
        (ref) {
  return FormularioPatientNotifier();
});
