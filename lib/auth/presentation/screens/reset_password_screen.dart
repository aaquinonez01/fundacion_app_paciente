import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/password_reset_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';

class ResetPasswordScreen extends ConsumerWidget {
  static const name = 'reset-password-screen';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordResetState = ref.watch(passwordResetProvider);
    final notifier = ref.read(passwordResetProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Restablecer Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Ingrese su nueva contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Campo de contraseña
            CustomTextFormField(
              prefixIcon: const Icon(Icons.lock),
              errorMessage: passwordResetState.isFormPosted
                  ? passwordResetState.newPassword.errorMessage
                  : null,
              label: 'Nueva Contraseña',
              hint: 'Ingrese su nueva contraseña',
              obscureText: true,
              onChanged: notifier.onNewPasswordChanged,
            ),
            const SizedBox(height: 30),

            // Botón para restablecer la contraseña
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  notifier.resetPassword();
                },
                child: const Text('Restablecer Contraseña'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
