import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/register_form_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            CustomTextFormField(
              prefixIcon: const Icon(Icons.email),
              errorMessage: registerForm.isFormPosted
                  ? registerForm.email.errorMessage
                  : null,
              label: 'Correo Electrónico',
              hint: 'Ingrese su Correo Electrónico',
              keyboardType: TextInputType.visiblePassword,
              onChanged: ref.read(registerFormProvider.notifier).onEmailChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.password.errorMessage
                  : null,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              label: 'Contraseña',
              hint: 'Ingrese su contraseña',
              keyboardType: TextInputType.visiblePassword,
              onChanged:
                  ref.read(registerFormProvider.notifier).onPasswordChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.username.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.person),
              label: 'Nombre de Usuario',
              hint: 'Ingrese su nombre de usuario',
              keyboardType: TextInputType.name,
              onChanged:
                  ref.read(registerFormProvider.notifier).onUsernameChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.firstname.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.person_2),
              label: 'Nombre',
              hint: 'Ingrese su nombre',
              keyboardType: TextInputType.name,
              onChanged:
                  ref.read(registerFormProvider.notifier).onFirstnameChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.lastname.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.person_2),
              label: 'Apellido',
              hint: 'Ingrese su apellido',
              keyboardType: TextInputType.name,
              onChanged:
                  ref.read(registerFormProvider.notifier).onLastnameChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.phone.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.phone),
              label: 'Telefono',
              hint: 'Ingrese su telefono',
              keyboardType: TextInputType.phone,
              onChanged: ref.read(registerFormProvider.notifier).onPhoneChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              errorMessage: registerForm.isFormPosted
                  ? registerForm.address.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.location_on),
              label: 'Direccion',
              hint: 'Ingrese su direccion',
              keyboardType: TextInputType.streetAddress,
              onChanged:
                  ref.read(registerFormProvider.notifier).onAddressChanged,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  registerForm.isPosting
                      ? null
                      : ref.read(registerFormProvider.notifier).onFormSubmit();
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
