import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_form_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_date_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/custom_text_form_fiield.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/header.dart';

class RegisterAppointment extends ConsumerWidget {
  const RegisterAppointment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AppointmentState>(appointmentProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      } else if (next.successMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cita registrada correctamente'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });

    final authState = ref.watch(authProvider);
    if (authState.user == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    final appointmentFormState = ref.watch(appointmentFormProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(top: 20, left: 40),
          child: Header(
            heightScale: 0.80,
            imagePath: 'assets/images/logo.png',
            title: 'Fundación de niños especiales',
            subtitle: '"SAN MIGUEL" FUNESAMI',
            item: '"Registrar Cita"',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información de la Cita',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              CustomDateFormField(
                lastDate: false,
                isDatePicker: true,
                errorMessage: appointmentFormState.isFormPosted
                    ? (appointmentFormState.selectedDate == null
                        ? 'Seleccione una fecha'
                        : null)
                    : null,
                prefixIcon: const Icon(Icons.calendar_today),
                label: 'Fecha de la Cita',
                hint: 'Seleccione la fecha',
                initialValue: appointmentFormState.selectedDate != null
                    ? "${appointmentFormState.selectedDate!.year}-${appointmentFormState.selectedDate!.month.toString().padLeft(2, '0')}-${appointmentFormState.selectedDate!.day.toString().padLeft(2, '0')}"
                    : '',
                onChanged: (value) {
                  try {
                    List<String> parts = value.split('/');
                    if (parts.length == 3) {
                      String formattedDate =
                          "${parts[2]}-${parts[1]}-${parts[0]}";
                      final date = DateTime.parse(formattedDate);
                      ref
                          .read(appointmentFormProvider.notifier)
                          .onDateChanged(date);
                    } else {
                      print("Error: Formato de fecha incorrecto");
                    }
                  } catch (e) {
                    print("Error al convertir fecha: $e");
                  }
                },
              ),
              const SizedBox(height: 15),
              CustomDropdownFormField(
                value: appointmentFormState.selectedTime,
                errorMessage: appointmentFormState.isFormPosted
                    ? (appointmentFormState.selectedTime == null
                        ? 'Seleccione una hora'
                        : null)
                    : null,
                label: 'Hora de la Cita',
                hint: 'Seleccione la hora',
                items: [
                  '08:00',
                  '08:30',
                  '09:00',
                  '09:30',
                  '10:00',
                  '10:30',
                  '11:00',
                  '11:30',
                  '12:00',
                  '12:30',
                  '13:00',
                  '13:30',
                  '14:00',
                  '14:30',
                  '15:00',
                  '15:30',
                  '16:00',
                  '16:30',
                ].map((hour) {
                  return DropdownMenuItem(value: hour, child: Text(hour));
                }).toList(),
                onChanged: (value) {
                  ref
                      .read(appointmentFormProvider.notifier)
                      .onTimeChanged(value ?? '');
                },
              ),
              const SizedBox(height: 15),
              CustomDropdownFormField(
                value: appointmentFormState.specialtyTherapyId,
                errorMessage: appointmentFormState.isFormPosted
                    ? (appointmentFormState.specialtyTherapyId == null
                        ? 'Seleccione una especialidad'
                        : null)
                    : null,
                label: 'Especialidad',
                hint: 'Seleccione una especialidad',
                items: appointmentFormState.areas.map((area) {
                  return DropdownMenuItem(
                      value: area.id, child: Text(area.name));
                }).toList(),
                onChanged: (value) {
                  ref
                      .read(appointmentFormProvider.notifier)
                      .onAreaChanged(value ?? '');
                },
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                initialValue: appointmentFormState.diagnosis,
                errorMessage: appointmentFormState.isFormPosted
                    ? (appointmentFormState.diagnosis.isEmpty
                        ? 'Ingrese un diagnóstico'
                        : null)
                    : null,
                prefixIcon: const Icon(Icons.medical_services),
                label: 'Diagnóstico',
                hint: 'Ingrese el diagnóstico',
                keyboardType: TextInputType.text,
                onChanged: ref
                    .read(appointmentFormProvider.notifier)
                    .onDiagnosisChanged,
              ),
              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(appointmentFormProvider.notifier)
                        .saveAppointment();
                  },
                  child: const Text('Guardar Cita'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
