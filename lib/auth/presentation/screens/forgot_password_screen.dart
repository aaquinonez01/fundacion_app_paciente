import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/password_reset_provider.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  static const name = 'forgot-password';
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordResetState = ref.watch(passwordResetProvider);
    final passwordResetNotifier = ref.read(passwordResetProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Ingresa tu correo para recibir un código',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                errorText: passwordResetState.isFormPosted
                    ? passwordResetState.email.errorMessage
                    : null,
                border: OutlineInputBorder(),
              ),
              onChanged: passwordResetNotifier.onEmailChanged,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await passwordResetNotifier.sendCode();
                context.push('/verify-code');
              },
              child: passwordResetState.isSubmitting
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Enviar Código"),
            ),
          ],
        ),
      ),
    );
  }
}
