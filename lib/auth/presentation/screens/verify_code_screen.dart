import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/password_reset_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/header.dart';

class VerifyCodeScreen extends ConsumerWidget {
  static const name = 'verify-code-screen';
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(passwordResetProvider.notifier);
    final passwordResetState = ref.watch(passwordResetProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Verificar Código')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Header(
              heightScale: 1.0,
              imagePath: 'assets/images/logo.png',
              title: 'Fundación de niños especiales',
              subtitle: '"SAN MIGUEL" FUNESAMI',
              item: '"Verificar Código"',
            ),
            const SizedBox(height: 30),
            const Text(
              'Ingrese el código enviado a su correo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              prefixIcon: const Icon(Icons.email),
              errorMessage: passwordResetState.isFormPosted
                  ? passwordResetState.code.errorMessage
                  : null,
              label: 'Código de Verificación',
              hint: 'Ingrese el código',
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.onCodeChanged,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  notifier.verifyCode();
                },
                child: const Text('Verificar Código'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
