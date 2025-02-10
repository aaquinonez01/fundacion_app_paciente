import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';

abstract class AppointmentDatasource {
  Future<List<Appointments>> getAppointmentsByStatus(String status);
  Future<void> createAppointment(Appointments appointment);
  Future<void> updateAppointment(Appointments appointment);
  Future<void> deleteAppointment(Appointments appointment);
}
