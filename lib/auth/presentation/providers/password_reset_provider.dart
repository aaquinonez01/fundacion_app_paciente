import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/inputs/email_input.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/inputs/password_input.dart';

// Estado del formulario de recuperación de contraseña
class PasswordResetState {
  final Email email;
  final String code;
  final Password newPassword;
  final bool isSubmitting;
  final bool isFormPosted;
  final bool isValid;
  final String errorMessage;

  const PasswordResetState({
    this.email = const Email.pure(),
    this.code = '',
    this.newPassword = const Password.pure(),
    this.isSubmitting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.errorMessage = '',
  });

  PasswordResetState copyWith({
    Email? email,
    String? code,
    Password? newPassword,
    bool? isSubmitting,
    bool? isFormPosted,
    bool? isValid,
    String? errorMessage,
  }) {
    return PasswordResetState(
      email: email ?? this.email,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PasswordResetNotifier extends StateNotifier<PasswordResetState> {
  PasswordResetNotifier() : super(const PasswordResetState());

  // Validar email
  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.newPassword]),
    );
  }

  // Enviar código de verificación
  Future<void> sendCode() async {
    _touchFields();
    if (!state.isValid) return;

    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(seconds: 2)); // Simulación de API

    // Simulamos éxito en el envío del código
    state = state.copyWith(isSubmitting: false, errorMessage: '');
  }

  // Validar código ingresado
  Future<bool> verifyCode(String inputCode) async {
    return inputCode == "123456"; // Código de prueba
  }

  // Validar nueva contraseña
  void onNewPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      newPassword: newPassword,
      isValid: Formz.validate([state.email, newPassword]),
    );
  }

  // Restablecer contraseña
  Future<void> resetPassword() async {
    _touchFields();
    if (!state.isValid) return;

    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(seconds: 2)); // Simulación de API

    state = state.copyWith(isSubmitting: false, errorMessage: '');
  }

  // Marcar los campos como modificados
  void _touchFields() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.newPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      newPassword: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

final passwordResetProvider = StateNotifierProvider.autoDispose<
    PasswordResetNotifier,
    PasswordResetState>((ref) => PasswordResetNotifier());
