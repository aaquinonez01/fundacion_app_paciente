import 'package:flutter/material.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';

class AppointmentDetailDialog extends StatelessWidget {
  final Appointments appointment;

  const AppointmentDetailDialog({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Detalles de la Cita'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(Icons.calendar_today, 'Fecha:', appointment.date),
          _buildDetailRow(
              Icons.access_time, 'Hora:', appointment.appointmentTime),
          _buildDetailRow(Icons.person, 'Paciente:', appointment.patient),
          _buildDetailRow(
              Icons.medical_services, 'Doctor:', appointment.doctor),
          _buildDetailRow(
              Icons.description, 'Diagnóstico:', appointment.diagnosis),
          _buildDetailRow(
              Icons.security, 'Seguro Médico:', appointment.medicalInsurance),
          _buildStatusRow(appointment.status), // Estado con color
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  /// 🔹 Widget para construir filas de detalles
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Widget para mostrar el estado de la cita con color
  Widget _buildStatusRow(String status) {
    Color statusColor = status == 'Agendado' ? Colors.green : Colors.orange;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.assignment, size: 20, color: statusColor),
          const SizedBox(width: 8),
          const Text('Estado: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
