import 'package:formz/formz.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_register.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState {
  String email;
  String password;
  String username;
  String firstname;
  String lastname;
  String phone;
  String address;

  RegisterState({
    this.email = '',
    this.password = '',
    this.username = '',
    this.firstname = '',
    this.lastname = '',
    this.phone = '',
    this.address = '',
  });
}

class FormularioState {
  final Email email;
  final Password password;
  final Username username;
  final Name firstname;
  final Lastname lastname;
  final Phone phone;
  final Address address;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  const FormularioState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.firstname = const Name.pure(),
    this.lastname = const Lastname.pure(),
    this.phone = const Phone.pure(),
    this.address = const Address.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
  });

  FormularioState copyWith({
    Email? email,
    Password? password,
    Username? username,
    Name? firstname,
    Lastname? lastname,
    Phone? phone,
    Address? address,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) {
    return FormularioState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
    );
  }
}

class FormularioNotifier extends StateNotifier<FormularioState> {
  final Function(UserRegister) registerUserCallback;
  FormularioNotifier({required this.registerUserCallback})
      : super(const FormularioState());

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: _validateForm(newEmail: newEmail),
    );
  }

  void onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: _validateForm(newPassword: newPassword),
    );
  }

  void onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      username: newUsername,
      isValid: _validateForm(newUsername: newUsername),
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

  void onPhoneChanged(String value) {
    final newPhone = Phone.dirty(value);
    state = state.copyWith(
      phone: newPhone,
      isValid: _validateForm(newPhone: newPhone),
    );
  }

  void onAddressChanged(String value) {
    final newAddress = Address.dirty(value);
    state = state.copyWith(
      address: newAddress,
      isValid: _validateForm(newAddress: newAddress),
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      final userRegister = UserRegister(
        email: state.email.value,
        password: state.password.value,
        username: state.username.value,
        userInformation: UserInformationRegister(
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          address: state.address.value,
          phone: state.phone.value,
        ),
      );
      await registerUserCallback(userRegister);
      print('Formulario enviado con éxito');
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final username = Username.dirty(state.username.value);
    final firstname = Name.dirty(state.firstname.value);
    final lastname = Lastname.dirty(state.lastname.value);
    final phone = Phone.dirty(state.phone.value);
    final address = Address.dirty(state.address.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      username: username,
      firstname: firstname,
      lastname: lastname,
      phone: phone,
      address: address,
      isValid: _validateForm(
        newEmail: email,
        newPassword: password,
        newUsername: username,
        newFirstname: firstname,
        newLastname: lastname,
        newPhone: phone,
        newAddress: address,
      ),
    );
  }

  bool _validateForm({
    Email? newEmail,
    Password? newPassword,
    Username? newUsername,
    Name? newFirstname,
    Lastname? newLastname,
    Phone? newPhone,
    Address? newAddress,
  }) {
    return Formz.validate([
      newEmail ?? state.email,
      newPassword ?? state.password,
      newUsername ?? state.username,
      newFirstname ?? state.firstname,
      newLastname ?? state.lastname,
      newPhone ?? state.phone,
      newAddress ?? state.address,
    ]);
  }
}

final registerFormProvider =
    StateNotifierProvider.autoDispose<FormularioNotifier, FormularioState>(
        (ref) {
  final register = ref.watch(authProvider.notifier).registerUser;
  return FormularioNotifier(
    registerUserCallback: register,
  );
});
