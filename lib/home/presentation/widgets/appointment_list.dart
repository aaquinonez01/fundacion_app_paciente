import 'package:flutter/material.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/appointment_detail_dialog.dart';

class AppointmentList extends StatelessWidget {
  final List<Appointments> appointments;

  const AppointmentList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              leading: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_today, color: Colors.white),
              ),
              title: Text(
                'Cita con ${appointment.doctor}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'Hora: ${appointment.appointmentTime}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AppointmentDetailDialog(appointment: appointment),
                  );
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text("Ver", style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
