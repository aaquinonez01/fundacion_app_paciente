import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/page_register_patient.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/register_patient.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/prueba.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';

class RegisterPatientPart2 extends ConsumerWidget {
  const RegisterPatientPart2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeTeraphy = [
      {'name': 'Terapia', 'value': 'TERAPIA'},
      {'name': 'Psicologia', 'value': 'PSICOLOGIA'},
    ];
    final registerPatientForm = ref.watch(registerPatientProvider);
    final pageState = ref.watch(pageControllerProvider);

    final currentPage = pageState.currentPage;
    return Column(children: [
      const SizedBox(
        height: 10,
      ),

      const Text('Informacion Médica',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      const SizedBox(
        height: 10,
      ),
      const CustomTextFormField(
        prefixIcon: Icon(Icons.medical_services),
        label: 'Seguro Social',
        hint: ('Ingrese su seguro social'),
        keyboardType: TextInputType.name,
      ),
      const SizedBox(
        height: 10,
      ),
      CustomInputList(
        label: 'Medicación Actual',
        hint: 'Agregar medicación',
        items: registerPatientForm
            .currentMedications, // Asumiendo que tienes medicación actual en tu estado
        onChanged: (newMedicacion) {
          ref
              .read(registerPatientProvider.notifier)
              .onCurrentMedicationsChanged(newMedicacion);
        },
      ),

      //Tipos de Terapia Requerida
      const SizedBox(
        height: 10,
      ),
      CustomDropdownFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.gender.errorMessage
            : null,
        label: 'Tipo de Terapia Requerida',
        onChanged: (newTherapy) {
          if (newTherapy != null) {
            ref
                .read(registerPatientProvider.notifier)
                .onTypeTherapyRequiredChanged([newTherapy]);
          }
        },
        hint: 'Seleccione el tipo de terapia requerida',
        items: typeTeraphy.map((type) {
          return DropdownMenuItem(
            value: type['value'],
            child: Text(type['name']!),
          );
        }).toList(),
      ),
      // CustomInputList(
      //   label: 'Tipo de Terapia Requerida',
      //   hint: 'Agregue el tipo de terapia requerida',
      //   items: registerPatientForm.type_therapy_required,
      //   onChanged: (newTherapy) {
      //     ref
      //         .read(registerPatientProvider.notifier)
      //         .onTypeTherapyRequiredChanged(newTherapy);
      //   },
      // ),

      const SizedBox(
        height: 10,
      ),
      CustomInputList(
        label: 'Alergias',
        hint: 'Agregar alergias',
        items: registerPatientForm
            .allergies, // Asumiendo que tienes medicación actual en tu estado
        onChanged: (newAllergy) {
          ref
              .read(registerPatientProvider.notifier)
              .onAllergiesChanged(newAllergy);
        },
      ),
      //Alergias
      const SizedBox(
        height: 10,
      ),
      CustomInputList(
        label: 'Discapacidades',
        hint: 'Agregar discapacidades',
        items: registerPatientForm
            .disabilities, // Asumiendo que tienes medicación actual en tu estado
        onChanged: (newDisability) {
          ref
              .read(registerPatientProvider.notifier)
              .onCurrentMedicationsChanged(newDisability);
        },
      ),
      //Medicacion actual
      const SizedBox(
        height: 10,
      ),

      const Spacer(),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 45,
            width: 150,
            child: FilledButton(
              onPressed: () {
                if (currentPage == 0) {
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
                      fontSize: 15,
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
                registerPatientForm.isPosting
                    ? null
                    : ref.read(registerPatientProvider.notifier).onFormSubmit();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
              ),
              child: const Text('Registrar Paciente',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
    ]);
  }
}
