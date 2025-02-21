import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/page_register.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/register_form_provider.dart';

class RegisterPatientPart1 extends ConsumerWidget {
  const RegisterPatientPart1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    final pageState = ref.watch(pageControllerProvider);
    final currentPage = pageState.currentPage;
    final scrollController = ScrollController();
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Información del Usuario',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.email_user.value,
          prefixIcon: const Icon(Icons.email),
          errorMessage: registerForm.isFormPosted
              ? registerForm.email_user.errorMessage
              : null,
          label: 'Correo Electrónico',
          hint: 'Ingrese su Correo Electrónico',
          keyboardType: TextInputType.visiblePassword,
          onChanged: ref.read(registerFormProvider.notifier).onEmailUserChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.password_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.password_user.errorMessage
              : null,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
          label: 'Contraseña',
          hint: 'Ingrese su contraseña',
          keyboardType: TextInputType.visiblePassword,
          onChanged:
              ref.read(registerFormProvider.notifier).onPasswordUserChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.username_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.username_user.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person),
          label: 'Nombre de Usuario',
          hint: 'Ingrese su nombre de usuario',
          keyboardType: TextInputType.name,
          onChanged:
              ref.read(registerFormProvider.notifier).onUsernameUserChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.firstname_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.firstname_user.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person_2),
          label: 'Nombre',
          hint: 'Ingrese su nombre',
          keyboardType: TextInputType.name,
          onChanged:
              ref.read(registerFormProvider.notifier).onFirstnameUserChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.lastname_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.lastname_user.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person_2),
          label: 'Apellido',
          hint: 'Ingrese su apellido',
          keyboardType: TextInputType.name,
          onChanged:
              ref.read(registerFormProvider.notifier).onLastnameUserChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
            initialValue: registerForm.phone_user.value,
            errorMessage: registerForm.isFormPosted
                ? registerForm.phone_user.errorMessage
                : null,
            prefixIcon: const Icon(Icons.phone),
            label: 'Teléfono',
            hint: 'Ingrese su teléfono',
            keyboardType: TextInputType.phone,
            onChanged:
                ref.read(registerFormProvider.notifier).onPhoneUserChanged),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          initialValue: registerForm.address_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.address_user.errorMessage
              : null,
          prefixIcon: const Icon(Icons.location_on),
          label: 'Dirección',
          hint: 'Ingrese su dirección',
          keyboardType: TextInputType.streetAddress,
          onChanged:
              ref.read(registerFormProvider.notifier).onAddressUserChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 45,
            width: 180,
            child: FilledButton(
              onPressed: () {
                ref.read(registerFormProvider.notifier).OnNextPage2();
                if (registerForm.isValid) {
                  if (currentPage == 0) {
                    ref.read(pageControllerProvider.notifier).nextPage();
                  } else {
                    ref.read(pageControllerProvider.notifier).previousPage();
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
              ),
              child: const Text('Siguiente',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ]),
    );
  }
}
