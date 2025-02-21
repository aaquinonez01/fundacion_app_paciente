import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:fundacion_paciente_app/auth/domain/repositories/auth_repository.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:fundacion_paciente_app/config/routes/app_routes.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/inputs/inputs.dart';

// Estado del formulario de recuperación de contraseña
class PasswordResetState {
  final Email email;
  final Name code;
  final Password newPassword;
  final bool isSubmitting;
  final bool isFormPosted;
  final bool isValid;
  final String errorMessage;

  const PasswordResetState({
    this.email = const Email.pure(),
    this.code = const Name.pure(),
    this.newPassword = const Password.pure(),
    this.isSubmitting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.errorMessage = '',
  });

  PasswordResetState copyWith({
    Email? email,
    Name? code,
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
  final AuthRepository authRepository;
  final Ref ref;
  PasswordResetNotifier({
    required this.ref,
    required this.authRepository,
  }) : super(const PasswordResetState());

  // Validar email
  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.code, state.newPassword]),
    );
  }

  void onCodeChanged(String value) {
    final newCode = Name.dirty(value);
    state = state.copyWith(
      code: newCode,
      isValid: Formz.validate([state.email, newCode, state.newPassword]),
    );
  }

  // Enviar código de verificación
  Future<void> sendCode() async {
    _touchFieldEmail();
    if (!state.isValid) return;

    try {
      state = state.copyWith(isSubmitting: true);
      await authRepository.sendCode(state.email.value);

      // Simulamos éxito en el envío del código
      state = state.copyWith(isSubmitting: false, errorMessage: '');
      ref.read(goRouterProvider).push('/reset-password/code');
    } on CustomError catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (e) {
      state =
          state.copyWith(isSubmitting: false, errorMessage: 'Error inesperado');
    }
  }

  // Validar código ingresado
  Future<void> verifyCode() async {
    _touchFieldCode();
    if (!state.isValid) return;
    print('Verificando código...');
    try {
      state = state.copyWith(isSubmitting: true);
      await authRepository.validateCode(
        state.email.value,
        state.code.value,
      );

      state = state.copyWith(isSubmitting: false, errorMessage: '');

      ref.read(goRouterProvider).push('/reset-password/new-password');
    } on CustomError catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } catch (e) {
      state =
          state.copyWith(isSubmitting: false, errorMessage: 'Error inesperado');
    }
  }

  // Validar nueva contraseña
  void onNewPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      newPassword: newPassword,
      isValid: Formz.validate([state.email, state.code, newPassword]),
    );
  }

  // Restablecer contraseña
  Future<void> resetPassword() async {
    _touchFields();
    if (!state.isValid) return;

    try {
      state = state.copyWith(isSubmitting: true);
      await authRepository.resetPassword(
        state.email.value,
        state.code.value,
        state.newPassword.value,
      );
      ref.read(goRouterProvider).push('/login');
      state = state.copyWith(isSubmitting: false, errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    }
  }

  // Marcar los campos como modificados
  void _touchFieldEmail() {
    final email = Email.dirty(state.email.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([email]),
    );
  }

  void _touchFieldCode() {
    final code = Name.dirty(state.code.value);

    state = state.copyWith(
      isFormPosted: true,
      code: code,
      isValid: Formz.validate([code]),
    );
  }

  void _touchFields() {
    final email = Email.dirty(state.email.value);
    final newPassword = Password.dirty(state.newPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      newPassword: newPassword,
      isValid: Formz.validate([email, newPassword]),
    );
  }
}

final passwordResetProvider = StateNotifierProvider.autoDispose<
    PasswordResetNotifier, PasswordResetState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return PasswordResetNotifier(authRepository: authRepository, ref: ref);
});
