import 'package:flutter/material.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/register_patient_controller.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/register_patient_part1.dart';

class RegisterPatientScreen extends StatelessWidget {
  static const String name = 'register-patient-screen';
  const RegisterPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Paciente',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RegisterPatientController()),
      ),
    );
  }
}
