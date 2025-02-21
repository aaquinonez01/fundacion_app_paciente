import 'dart:math';

import 'package:formz/formz.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_register.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormularioState {
  final Email email_user;
  final Password password_user;
  final Username username_user;
  final Name firstname_user;
  final Lastname lastname_user;
  final Phone phone_user;
  final Address address_user;

  final Cedula cedula_patient;
  final Name firstname_patient;
  final Lastname lastname_patient;
  final Date date_patient;
  final Gender gender_patient;
  final Name guardian_legal_patient;
  final RelationLegalGuardian relation_legal_guardian_patient;
  final Name health_insurance_patient;
  final List<String> type_therapy_required_patient;
  final List<String> disabilities_patient;
  final List<String> allergies_patient;
  final List<String> current_medications_patient;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  const FormularioState({
    this.email_user = const Email.pure(),
    this.password_user = const Password.pure(),
    this.username_user = const Username.pure(),
    this.firstname_user = const Name.pure(),
    this.lastname_user = const Lastname.pure(),
    this.phone_user = const Phone.pure(),
    this.address_user = const Address.pure(),
    this.cedula_patient = const Cedula.pure(),
    this.firstname_patient = const Name.pure(),
    this.lastname_patient = const Lastname.pure(),
    this.date_patient = const Date.pure(),
    this.gender_patient = const Gender.pure(),
    this.guardian_legal_patient = const Name.pure(),
    this.relation_legal_guardian_patient = const RelationLegalGuardian.pure(),
    this.health_insurance_patient = const Name.pure(),
    this.disabilities_patient = const [],
    this.allergies_patient = const [],
    this.current_medications_patient = const [],
    this.type_therapy_required_patient = const [],
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
  });

  FormularioState copyWith({
    Email? email_user,
    Password? password_user,
    Username? username_user,
    Name? firstname_user,
    Lastname? lastname_user,
    Phone? phone_user,
    Address? address_user,
    Cedula? cedula_patient,
    Name? firstname_patient,
    Lastname? lastname_patient,
    Date? date_patient,
    Gender? gender_patient,
    Name? guardian_legal_patient,
    RelationLegalGuardian? relation_legal_guardian_patient,
    Name? health_insurance_patient,
    List<String>? disabilities_patient,
    List<String>? allergies_patient,
    List<String>? current_medications_patient,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) {
    return FormularioState(
      email_user: email_user ?? this.email_user,
      password_user: password_user ?? this.password_user,
      username_user: username_user ?? this.username_user,
      firstname_user: firstname_user ?? this.firstname_user,
      lastname_user: lastname_user ?? this.lastname_user,
      phone_user: phone_user ?? this.phone_user,
      address_user: address_user ?? this.address_user,
      cedula_patient: cedula_patient ?? this.cedula_patient,
      firstname_patient: firstname_patient ?? this.firstname_patient,
      lastname_patient: lastname_patient ?? this.lastname_patient,
      date_patient: date_patient ?? this.date_patient,
      gender_patient: gender_patient ?? this.gender_patient,
      guardian_legal_patient:
          guardian_legal_patient ?? this.guardian_legal_patient,
      relation_legal_guardian_patient: relation_legal_guardian_patient ??
          this.relation_legal_guardian_patient,
      health_insurance_patient:
          health_insurance_patient ?? this.health_insurance_patient,
      disabilities_patient: disabilities_patient ?? this.disabilities_patient,
      allergies_patient: allergies_patient ?? this.allergies_patient,
      current_medications_patient:
          current_medications_patient ?? this.current_medications_patient,
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
    );
  }
}

class FormularioNotifier extends StateNotifier<FormularioState> {
  final Function(RequestData) registerUserCallback;
  FormularioNotifier({required this.registerUserCallback})
      : super(const FormularioState());

  void onEmailUserChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email_user: newEmail,
      isValid: _validateForm(newEmailUser: newEmail),
    );
  }

  void onPasswordUserChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password_user: newPassword,
      isValid: _validateForm(newPasswordUser: newPassword),
    );
  }

  void onUsernameUserChanged(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      username_user: newUsername,
      isValid: _validateForm(newUsernameUser: newUsername),
    );
  }

  void onFirstnameUserChanged(String value) {
    final newFirstname = Name.dirty(value);
    state = state.copyWith(
      firstname_user: newFirstname,
      isValid: _validateForm(newFirstnameUser: newFirstname),
    );
  }

  void onLastnameUserChanged(String value) {
    final newLastname = Lastname.dirty(value);
    state = state.copyWith(
      lastname_user: newLastname,
      isValid: _validateForm(newLastnameUser: newLastname),
    );
  }

  void onPhoneUserChanged(String value) {
    final newPhone = Phone.dirty(value);
    state = state.copyWith(
      phone_user: newPhone,
      isValid: _validateForm(newPhoneUser: newPhone),
    );
  }

  void onAddressUserChanged(String value) {
    final newAddress = Address.dirty(value);
    state = state.copyWith(
      address_user: newAddress,
      isValid: _validateForm(newAddressUser: newAddress),
    );
  }

  void onCedulaPatientChanged(String value) {
    final newCedula = Cedula.dirty(value);
    state = state.copyWith(
      cedula_patient: newCedula,
      isValid: _validateForm(newCedulaPatient: newCedula),
    );
  }

  void onFirstnamePatientChanged(String value) {
    final newFirstname = Name.dirty(value);
    state = state.copyWith(
      firstname_patient: newFirstname,
      isValid: _validateForm(newFirstnamePatient: newFirstname),
    );
  }

  void onLastnamePatientChanged(String value) {
    final newLastname = Lastname.dirty(value);
    state = state.copyWith(
      lastname_patient: newLastname,
      isValid: _validateForm(newLastnamePatient: newLastname),
    );
  }

  void onDatePatientChanged(String value) {
    final newDate = Date.dirty(value);
    state = state.copyWith(
      date_patient: newDate,
      isValid: _validateForm(newDatePatient: newDate),
    );
  }

  void onGenderPatientChanged(String value) {
    final newGenderPatient = Gender.dirty(value);
    state = state.copyWith(
      gender_patient: newGenderPatient,
      isValid: _validateForm(newGenderPatient: newGenderPatient),
    );
  }

  void onGuardianLegalPatientChanged(String value) {
    final newGuardianLegalPatient = Name.dirty(value);
    state = state.copyWith(
      guardian_legal_patient: newGuardianLegalPatient,
      isValid: _validateForm(newGuardianLegalPatient: newGuardianLegalPatient),
    );
  }

  void onRelationLegalGuardianPatientChanged(String value) {
    final newRelationLegalGuardianPatient = RelationLegalGuardian.dirty(value);
    state = state.copyWith(
      relation_legal_guardian_patient: newRelationLegalGuardianPatient,
      isValid: _validateForm(
          newRelationLegalGuardianPatient: newRelationLegalGuardianPatient),
    );
  }

  void onHealthInsurancePatientChanged(String value) {
    final newHealthInsurancePatient = Name.dirty(value);
    state = state.copyWith(
      health_insurance_patient: newHealthInsurancePatient,
      isValid:
          _validateForm(newHealthInsurancePatient: newHealthInsurancePatient),
    );
  }

  void onDisabilitiesPatientChanged(List<String> value) {
    state = state.copyWith(disabilities_patient: value);
  }

  void onAllergiesPatientChanged(List<String> value) {
    state = state.copyWith(allergies_patient: value);
  }

  void onCurrentMedicationsPatientChanged(List<String> value) {
    state = state.copyWith(current_medications_patient: value);
  }

  void OnNextPage2() {
    _touchEveryFieldPart1();
    print(state.isValid);
    if (!state.isValid) return;
    print("Página 2");
  }

  void OnNextPage3() {
    _touchEveryFieldPart2();
    if (!state.isValid) return;
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      final userRegister = RequestData(
        createUser: CreateUser(
          email: state.email_user.value,
          password: state.password_user.value,
          username: state.username_user.value,
          userInformation: UserInformation(
            firstname: state.firstname_user.value,
            lastname: state.lastname_user.value,
            phone: state.phone_user.value,
            address: state.address_user.value,
          ),
        ),
        createPatient: CreatePatient(
            firstname: state.firstname_patient.value,
            lastname: state.lastname_patient.value,
            birthdate: state.date_patient.value,
            legalGuardian: state.guardian_legal_patient.value,
            dni: state.cedula_patient.value,
            disability: state.disabilities_patient,
            allergies: state.allergies_patient,
            currentMedications: state.current_medications_patient,
            gender: state.gender_patient.value,
            relationshipRepresentativePatient:
                state.relation_legal_guardian_patient.value,
            healthInsurance: state.health_insurance_patient.value,
            historyTreatmentsReceived: ["None"]),
      );
      await registerUserCallback(userRegister);
      print('Formulario enviado con éxito');
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryFieldPart1() {
    final email_user = Email.dirty(state.email_user.value);
    final password_user = Password.dirty(state.password_user.value);
    final username_user = Username.dirty(state.username_user.value);
    final firstname_user = Name.dirty(state.firstname_user.value);
    final lastname_user = Lastname.dirty(state.lastname_user.value);
    final phone_user = Phone.dirty(state.phone_user.value);
    final address_user = Address.dirty(state.address_user.value);

    state = state.copyWith(
      isFormPosted: true,
      email_user: email_user,
      password_user: password_user,
      username_user: username_user,
      firstname_user: firstname_user,
      lastname_user: lastname_user,
      phone_user: phone_user,
      address_user: address_user,
      isValid: _validateFormPart1(
        newEmailUser: email_user,
        newPasswordUser: password_user,
        newUsernameUser: username_user,
        newFirstnameUser: firstname_user,
        newLastnameUser: lastname_user,
        newPhoneUser: phone_user,
        newAddressUser: address_user,
      ),
    );
  }

  void _touchEveryFieldPart2() {
    final cedula_patient = Cedula.dirty(state.cedula_patient.value);
    final firstname_patient = Name.dirty(state.firstname_patient.value);
    final lastname_patient = Lastname.dirty(state.lastname_patient.value);
    final date_patient = Date.dirty(state.date_patient.value);
    final gender_patient = Gender.dirty(state.gender_patient.value);
    final guardian_legal_patient =
        Name.dirty(state.guardian_legal_patient.value);
    final relation_legal_guardian_patient = RelationLegalGuardian.dirty(
        state.relation_legal_guardian_patient.value);

    state = state.copyWith(
      isFormPosted: true,
      cedula_patient: cedula_patient,
      firstname_patient: firstname_patient,
      lastname_patient: lastname_patient,
      date_patient: date_patient,
      gender_patient: gender_patient,
      guardian_legal_patient: guardian_legal_patient,
      relation_legal_guardian_patient: relation_legal_guardian_patient,
      isValid: _validateFormPart2(
        newCedulaPatient: cedula_patient,
        newFirstnamePatient: firstname_patient,
        newLastnamePatient: lastname_patient,
        newDatePatient: date_patient,
        newGenderPatient: gender_patient,
        newGuardianLegalPatient: guardian_legal_patient,
        newRelationLegalGuardianPatient: relation_legal_guardian_patient,
      ),
    );
  }

  void _touchEveryField() {
    final email_user = Email.dirty(state.email_user.value);
    final password_user = Password.dirty(state.password_user.value);
    final username_user = Username.dirty(state.username_user.value);
    final firstname_user = Name.dirty(state.firstname_user.value);
    final lastname_user = Lastname.dirty(state.lastname_user.value);
    final phone_user = Phone.dirty(state.phone_user.value);
    final address_user = Address.dirty(state.address_user.value);
    final cedula_patient = Cedula.dirty(state.cedula_patient.value);
    final firstname_patient = Name.dirty(state.firstname_patient.value);
    final lastname_patient = Lastname.dirty(state.lastname_patient.value);
    final date_patient = Date.dirty(state.date_patient.value);
    final gender_patient = Gender.dirty(state.gender_patient.value);
    final guardian_legal_patient =
        Name.dirty(state.guardian_legal_patient.value);
    final relation_legal_guardian_patient = RelationLegalGuardian.dirty(
        state.relation_legal_guardian_patient.value);
    final health_insurance_patient =
        Name.dirty(state.health_insurance_patient.value);
    final disabilities_patient = state.disabilities_patient ?? [];
    final allergies_patient = state.allergies_patient ?? [];
    final current_medications_patient = state.current_medications_patient ?? [];

    state = state.copyWith(
      isFormPosted: true,
      email_user: email_user,
      password_user: password_user,
      username_user: username_user,
      firstname_user: firstname_user,
      lastname_user: lastname_user,
      phone_user: phone_user,
      address_user: address_user,
      cedula_patient: cedula_patient,
      firstname_patient: firstname_patient,
      lastname_patient: lastname_patient,
      date_patient: date_patient,
      gender_patient: gender_patient,
      guardian_legal_patient: guardian_legal_patient,
      relation_legal_guardian_patient: relation_legal_guardian_patient,
      health_insurance_patient: health_insurance_patient,
      disabilities_patient: disabilities_patient,
      allergies_patient: allergies_patient,
      current_medications_patient: current_medications_patient,
      isValid: _validateForm(
        newEmailUser: email_user,
        newPasswordUser: password_user,
        newUsernameUser: username_user,
        newFirstnameUser: firstname_user,
        newLastnameUser: lastname_user,
        newPhoneUser: phone_user,
        newAddressUser: address_user,
        newCedulaPatient: cedula_patient,
        newFirstnamePatient: firstname_patient,
        newLastnamePatient: lastname_patient,
        newDatePatient: date_patient,
        newGenderPatient: gender_patient,
        newGuardianLegalPatient: guardian_legal_patient,
        newRelationLegalGuardianPatient: relation_legal_guardian_patient,
        newHealthInsurancePatient: health_insurance_patient,
      ),
    );
  }

  bool _validateFormPart1({
    Email? newEmailUser,
    Password? newPasswordUser,
    Username? newUsernameUser,
    Name? newFirstnameUser,
    Lastname? newLastnameUser,
    Phone? newPhoneUser,
    Address? newAddressUser,
  }) {
    return Formz.validate([
      newEmailUser ?? state.email_user,
      newPasswordUser ?? state.password_user,
      newUsernameUser ?? state.username_user,
      newFirstnameUser ?? state.firstname_user,
      newLastnameUser ?? state.lastname_user,
      newPhoneUser ?? state.phone_user,
      newAddressUser ?? state.address_user,
    ]);
  }

  bool _validateFormPart2({
    Cedula? newCedulaPatient,
    Name? newFirstnamePatient,
    Lastname? newLastnamePatient,
    Date? newDatePatient,
    Gender? newGenderPatient,
    Name? newGuardianLegalPatient,
    RelationLegalGuardian? newRelationLegalGuardianPatient,
  }) {
    return Formz.validate([
      newCedulaPatient ?? state.cedula_patient,
      newFirstnamePatient ?? state.firstname_patient,
      newLastnamePatient ?? state.lastname_patient,
      newDatePatient ?? state.date_patient,
      newGenderPatient ?? state.gender_patient,
      newGuardianLegalPatient ?? state.guardian_legal_patient,
      newRelationLegalGuardianPatient ?? state.relation_legal_guardian_patient,
    ]);
  }

  bool _validateForm({
    Email? newEmailUser,
    Password? newPasswordUser,
    Username? newUsernameUser,
    Name? newFirstnameUser,
    Lastname? newLastnameUser,
    Phone? newPhoneUser,
    Address? newAddressUser,
    Cedula? newCedulaPatient,
    Name? newFirstnamePatient,
    Lastname? newLastnamePatient,
    Date? newDatePatient,
    Gender? newGenderPatient,
    Name? newGuardianLegalPatient,
    RelationLegalGuardian? newRelationLegalGuardianPatient,
    Name? newHealthInsurancePatient,
  }) {
    return Formz.validate([
      newEmailUser ?? state.email_user,
      newPasswordUser ?? state.password_user,
      newUsernameUser ?? state.username_user,
      newFirstnameUser ?? state.firstname_user,
      newLastnameUser ?? state.lastname_user,
      newPhoneUser ?? state.phone_user,
      newAddressUser ?? state.address_user,
      newCedulaPatient ?? state.cedula_patient,
      newFirstnamePatient ?? state.firstname_patient,
      newLastnamePatient ?? state.lastname_patient,
      newDatePatient ?? state.date_patient,
      newGenderPatient ?? state.gender_patient,
      newGuardianLegalPatient ?? state.guardian_legal_patient,
      newRelationLegalGuardianPatient ?? state.relation_legal_guardian_patient,
      newHealthInsurancePatient ?? state.health_insurance_patient,
    ]);
  }

  void setInitialData() {
    state = state.copyWith(
      email_user: Email.dirty('adsalguero@espe.edu.ec'),
      password_user: Password.dirty('!David123'),
      username_user: Username.dirty('davidsalguero1'),
      firstname_user: Name.dirty('David'),
      lastname_user: Lastname.dirty('Salguero'),
      phone_user: Phone.dirty('0989815664'),
      address_user: Address.dirty('123 Main Street'),
      cedula_patient: Cedula.dirty('0804199238'),
      firstname_patient: Name.dirty('David'),
      lastname_patient: Lastname.dirty('Salguero'),
      date_patient: Date.dirty('17/01/2019'),
      gender_patient: Gender.dirty('MUJER'),
      guardian_legal_patient: Name.dirty('David Salguero'),
      relation_legal_guardian_patient: RelationLegalGuardian.dirty('PADRE'),
      health_insurance_patient: Name.dirty('ISSFA'),
      disabilities_patient: ['Discapacidad Visual'],
      allergies_patient: ['Polen'],
      current_medications_patient: ['Ibuprofeno'],
      isValid: true,
    );
  }
}

final registerFormProvider =
    StateNotifierProvider<FormularioNotifier, FormularioState>((ref) {
  final register = ref.watch(authProvider.notifier).registerUser;
  final formularioNotifier = FormularioNotifier(registerUserCallback: register);

  // Llamar la función para inicializar los datos con valores de prueba
  formularioNotifier.setInitialData();

  return formularioNotifier;
});
