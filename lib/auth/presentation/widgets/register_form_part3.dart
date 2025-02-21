import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/page_register.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/register_form_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/prueba.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_dropdown_form_field.dart';

class RegisterPatientPart3 extends ConsumerWidget {
  const RegisterPatientPart3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeTeraphy = [
      {'name': 'Issfa', 'value': 'ISSFA'},
      {'name': 'Ninguno', 'value': 'NINGUNO'},
    ];
    final pageState = ref.watch(pageControllerProvider);
    final registerForm = ref.watch(registerFormProvider);
    final colors = Theme.of(context).colorScheme;
    final scrollController = ScrollController();
    final currentPage = pageState.currentPage;
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),

        const Text('Información Médica del Paciente',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          Text(
            "",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: registerForm.isFormPosted
                  ? registerForm.health_insurance_patient.errorMessage != null
                      ? Colors.red
                      : colors.primary
                  : colors.primary,
            ),
          ),
        ]),
        const SizedBox(
          height: 15,
        ),
        CustomDropdownFormField(
          errorMessage: registerForm.isFormPosted
              ? registerForm.health_insurance_patient.errorMessage != null
                  ? 'Este campo es requerido'
                  : null
              : null,
          label: 'Seguro Social',
          onChanged: (newTherapy) {
            if (newTherapy != null) {
              ref
                  .read(registerFormProvider.notifier)
                  .onHealthInsurancePatientChanged(newTherapy);
            }
          },
          hint: 'Seleccione el seguro social',
          items: typeTeraphy.map((type) {
            return DropdownMenuItem(
              value: type['value'],
              child: Text(type['name']!),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomInputList(
          label: 'Medicación Actual',
          hint: 'Agregar medicación',
          items: registerForm
              .current_medications_patient, // Asumiendo que tienes medicación actual en tu estado
          onChanged: (newMedicacion) {
            ref
                .read(registerFormProvider.notifier)
                .onCurrentMedicationsPatientChanged(newMedicacion);
          },
        ),

        //Tipos de Terapia Requerida
        const SizedBox(
          height: 10,
        ),

        CustomInputList(
          label: 'Alergias',
          hint: 'Agregar alergias',
          items: registerForm
              .allergies_patient, // Asumiendo que tienes medicación actual en tu estado
          onChanged: (newAllergy) {
            ref
                .read(registerFormProvider.notifier)
                .onAllergiesPatientChanged(newAllergy);
          },
        ),
        //Alergias
        const SizedBox(
          height: 10,
        ),
        CustomInputList(
          label: 'Discapacidades',
          hint: 'Agregar discapacidades',
          items: registerForm
              .disabilities_patient, // Asumiendo que tienes medicación actual en tu estado
          onChanged: (newDisability) {
            ref
                .read(registerFormProvider.notifier)
                .onDisabilitiesPatientChanged(newDisability);
          },
        ),
        //Medicacion actual
        const SizedBox(
          height: 10,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
              width: 150,
              child: FilledButton(
                onPressed: () {
                  if (currentPage != 2) {
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
              width: 220,
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
                child: const Text('Registrar Cuenta',
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
