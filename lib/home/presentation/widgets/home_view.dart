import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/appointment_list.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final colors = Theme.of(context).colorScheme;
    final appointments = ref.watch(appointmentProvider).appointments;
    final notifier = ref.read(appointmentProvider.notifier);

    // 🔹 Filtrar citas por estado
    final citasAgendadas =
        appointments.where((cita) => cita.status == 'Agendado').toList();
    final citasPendientes =
        appointments.where((cita) => cita.status == 'Pendiente').toList();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 🔹 Sección de bienvenida con botón de recarga
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '¡Bienvenido, ${user!.userInformation.firstName}!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, size: 28, color: Colors.blue),
                onPressed: () {
                  notifier.getAppointments();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Actualizando citas...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Fundación de niños especiales "SAN MIGUEL" FUNESAMI',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // 🔹 Si no hay citas, mostrar botón para agendar la primera cita
          if (appointments.isEmpty) ...[
            ElevatedButton(
              onPressed: () {
                context.push('/register-appointment');
              },
              child: const Text('Agendar tu Primera Cita'),
            ),
          ] else ...[
            // 🔹 Si hay citas agendadas, mostrar sección
            if (citasAgendadas.isNotEmpty) ...[
              const Text(
                'Citas Agendadas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(child: AppointmentList(appointments: citasAgendadas)),
              const SizedBox(height: 20),
            ] else ...[
              const Text(
                'No tienes citas agendadas',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],

            // 🔹 Si hay citas pendientes, mostrar sección
            if (citasPendientes.isNotEmpty) ...[
              const Text(
                'Citas Pendientes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(child: AppointmentList(appointments: citasPendientes)),
            ] else ...[
              const Text(
                'No tienes citas pendientes',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
