import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/page_register.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/register_form_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_date_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';

class RegisterPatientPart2 extends ConsumerWidget {
  const RegisterPatientPart2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    final pageState = ref.watch(pageControllerProvider);
    final currentPage = pageState.currentPage;
    final scrollController = ScrollController();
    final genders = [
      {'name': 'Masculino', 'value': 'HOMBRE'},
      {'name': 'Femenino', 'value': 'MUJER'},
      {'name': 'Otro', 'value': 'OTRO'},
    ];
    final relations = [
      {'name': 'Padre', 'value': 'PADRE'},
      {'name': 'Madre', 'value': 'MADRE'},
      {'name': 'Hermano', 'value': 'HERMANO'},
      {'name': 'Hermana', 'value': 'HERMANA'},
      {'name': 'Tio', 'value': 'TIO'},
      {'name': 'Tia', 'value': 'TIA'},
      {'name': 'Abuelo', 'value': 'ABUELO'},
      {'name': 'Abuela', 'value': 'ABUELA'},
      {'name': 'Guardian Legal', 'value': 'GUARDIAN_LEGAL'},
    ];
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          textAlign: TextAlign.start,
          'Información Personal del Paciente',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          initialValue: registerForm.cedula_patient.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.cedula_patient.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person_2_rounded),
          label: 'Cédula de Ciudadanía',
          hint: 'Ingrese su cédula de ciudadanía',
          keyboardType: TextInputType.emailAddress,
          onChanged:
              ref.read(registerFormProvider.notifier).onCedulaPatientChanged,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          initialValue: registerForm.firstname_patient.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.firstname_patient.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person),
          label: 'Nombre',
          hint: 'Ingrese su nombre',
          keyboardType: TextInputType.name,
          onChanged:
              ref.read(registerFormProvider.notifier).onFirstnamePatientChanged,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          initialValue: registerForm.lastname_patient.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.lastname_patient.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person),
          label: 'Apellido',
          hint: 'Ingrese su apellido',
          keyboardType: TextInputType.name,
          onChanged:
              ref.read(registerFormProvider.notifier).onLastnamePatientChanged,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomDateFormField(
          isDatePicker: true,
          errorMessage: registerForm.isFormPosted
              ? registerForm.date_patient.errorMessage
              : null,
          prefixIcon: const Icon(Icons.calendar_today),
          label: 'Fecha de Nacimiento',
          hint: 'Seleccione su fecha de nacimiento',
          keyboardType: TextInputType.text,
          onChanged:
              ref.read(registerFormProvider.notifier).onDatePatientChanged,
          initialValue: registerForm
              .date_patient.value, // Este es el valor de la fecha actual
        ),

        const SizedBox(
          height: 15,
        ),

        CustomDropdownFormField(
          value: registerForm.gender_patient.value.isNotEmpty
              ? registerForm.gender_patient.value
              : null,
          errorMessage: registerForm.isFormPosted
              ? registerForm.gender_patient.errorMessage
              : null,
          label: 'Género',
          onChanged: (value) {
            final valueD = value ?? '';
            ref
                .read(registerFormProvider.notifier)
                .onGenderPatientChanged(valueD);
          },
          hint: 'Seleccione su género',
          items: genders.map((gender) {
            return DropdownMenuItem(
              value: gender['value'],
              child: Text(gender['name']!),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 15,
        ),
        //Guardian legal
        CustomDropdownFormField(
            value: registerForm.relation_legal_guardian_patient.value.isNotEmpty
                ? registerForm.relation_legal_guardian_patient.value
                : null,
            errorMessage: registerForm.isFormPosted
                ? registerForm.relation_legal_guardian_patient.errorMessage
                : null,
            prefixIcon: const Icon(Icons.person),
            label: 'Relación con el Paciente',
            items: relations.map((relation) {
              return DropdownMenuItem(
                value: relation['value'],
                child: Text(relation['name']!),
              );
            }).toList(),
            hint: 'Seleccione su relación con el paciente',
            onChanged: (value) {
              final valueD = value ?? '';
              ref
                  .read(registerFormProvider.notifier)
                  .onRelationLegalGuardianPatientChanged(valueD);
            }),
        const SizedBox(
          height: 15,
        ),
        //Relacion con el guardian legal
        CustomTextFormField(
          initialValue: registerForm.firstname_user.value,
          errorMessage: registerForm.isFormPosted
              ? registerForm.guardian_legal_patient.errorMessage
              : null,
          prefixIcon: const Icon(Icons.person),
          label: 'Guardián Legal',
          hint: 'Ingrese el nombre de su guardián legal',
          keyboardType: TextInputType.name,
          onChanged: ref
              .read(registerFormProvider.notifier)
              .onGuardianLegalPatientChanged,
        ),

        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
              width: 150,
              child: FilledButton(
                onPressed: () {
                  if (currentPage < 1) {
                    ref.read(pageControllerProvider.notifier).nextPage();
                  } else {
                    ref.read(pageControllerProvider.notifier).previousPage();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                ),
                child: const Text('Anterior',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 45,
              width: 180,
              child: FilledButton(
                onPressed: () {
                  ref.read(registerFormProvider.notifier).OnNextPage3();
                  if (registerForm.isValid) {
                    if (currentPage == 1) {
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
          ],
        ),
      ]),
    );
  }
}
