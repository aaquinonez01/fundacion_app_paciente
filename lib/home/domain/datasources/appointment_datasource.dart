import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/entities/registerCita.entity.dart';

abstract class AppointmentDatasource {
  Future<List<Appointments>> getAppointmentsByDate(DateTime date);
  Future<List<Appointments>> getAppointments();
  Future<void> createAppointment(CreateAppointments appointment);
  Future<void> updateAppointment(Appointments appointment);
  Future<void> deleteAppointment(Appointments appointment);
}
