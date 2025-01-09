import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/page_register_patient.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/register_patient.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_field.dart';

class RegisterPatientPart1 extends ConsumerWidget {
  const RegisterPatientPart1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerPatientForm = ref.watch(registerPatientProvider);
    final pageState = ref.watch(pageControllerProvider);
    print(registerPatientForm.date.value);
    final currentPage = pageState.currentPage;
    final genders = [
      {'name': 'Masculino', 'value': 'MASCULINO'},
      {'name': 'Femenino', 'value': 'FEMENINO'},
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
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      const Text(
        textAlign: TextAlign.start,
        'Información Personal',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.cedula.errorMessage
            : null,
        prefixIcon: const Icon(Icons.person_2_rounded),
        label: 'Cedula de Ciudadanía',
        hint: 'Ingrese su cedula de ciudadanía',
        keyboardType: TextInputType.emailAddress,
        onChanged: ref.read(registerPatientProvider.notifier).onCedulaChanged,
      ),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.firstname.errorMessage
            : null,
        prefixIcon: const Icon(Icons.person),
        label: 'Nombre',
        hint: 'Ingrese su nombre',
        keyboardType: TextInputType.name,
        onChanged:
            ref.read(registerPatientProvider.notifier).onFirstnameChanged,
      ),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.lastname.errorMessage
            : null,
        prefixIcon: const Icon(Icons.person),
        label: 'Apellido',
        hint: 'Ingrese su apellido',
        keyboardType: TextInputType.name,
        onChanged: ref.read(registerPatientProvider.notifier).onLastnameChanged,
      ),
      const SizedBox(
        height: 15,
      ),
      CustomTextFormField(
        isDatePicker: true,
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.date.errorMessage
            : null,
        prefixIcon: const Icon(Icons.calendar_today),
        label: 'Fecha de Nacimiento',
        hint: 'Seleccione su fecha de nacimiento',
        keyboardType: TextInputType.text,
        onChanged: ref.read(registerPatientProvider.notifier).onDateChanged,
        initialValue: registerPatientForm
            .date.value, // Este es el valor de la fecha actual
      ),

      const SizedBox(
        height: 15,
      ),

      CustomDropdownFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.gender.errorMessage
            : null,
        label: 'Género',
        onChanged: (value) {
          final valueD = value ?? '';
          ref.read(registerPatientProvider.notifier).onGenderChanged(valueD);
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
          errorMessage: registerPatientForm.isFormPosted
              ? registerPatientForm.relation_legal_guardian.errorMessage
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
                .read(registerPatientProvider.notifier)
                .onRelationLegalGuardianChanged(valueD);
          }),
      const SizedBox(
        height: 15,
      ),
      //Relacion con el guardian legal
      CustomTextFormField(
        errorMessage: registerPatientForm.isFormPosted
            ? registerPatientForm.guardian_legal.errorMessage
            : null,
        prefixIcon: const Icon(Icons.person),
        label: 'Guardian Legal',
        hint: 'Ingrese el nombre de su guardian legal',
        keyboardType: TextInputType.name,
        onChanged:
            ref.read(registerPatientProvider.notifier).onGuardianLegalChanged,
      ),

      const SizedBox(
        height: 15,
      ),
      const Spacer(),

      Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 45,
          width: 180,
          child: FilledButton(
            onPressed: () {
              ref.read(registerPatientProvider.notifier).OnNextPage();
              if (registerPatientForm.isValid) {
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
      const SizedBox(
        height: 30,
      ),
    ]);
  }
}
