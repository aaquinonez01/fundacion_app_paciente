import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/login_form_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(formularioProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            CustomTextFormField(
              prefixIcon: const Icon(Icons.email),
              errorMessage:
                  loginForm.isFormPosted ? loginForm.email.errorMessage : null,
              label: 'Correo Electrónico',
              hint: 'Ingrese su correo electrónico',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: ref.read(formularioProvider.notifier).onEmailChanged,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              errorMessage: loginForm.isFormPosted
                  ? loginForm.password.errorMessage
                  : null,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              label: 'Contraseña',
              hint: 'Ingrese su contraseña',
              keyboardType: TextInputType.visiblePassword,
              onChanged:
                  ref.read(formularioProvider.notifier).onPasswordChanged,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  loginForm.isPosting
                      ? null
                      : ref.read(formularioProvider.notifier).onFormSubmit();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                ),
                child: const Text('Ingresar',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
