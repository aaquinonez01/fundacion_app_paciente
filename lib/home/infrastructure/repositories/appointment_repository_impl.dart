import 'package:fundacion_paciente_app/home/domain/datasources/appointment_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/entities/registerCita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/appointment_repository.dart';
import 'package:fundacion_paciente_app/home/infrastructure/datasources/appointment_datasource_impl.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDatasource datasource;

  AppointmentRepositoryImpl({AppointmentDatasource? datasource})
      : datasource = datasource ?? AppointmentDatasourceImpl();
  @override
  Future<void> createAppointment(CreateAppointments appointment) {
    return datasource.createAppointment(appointment);
  }

  @override
  Future<void> deleteAppointment(Appointments appointment) {
    return datasource.deleteAppointment(appointment);
  }

  @override
  Future<List<Appointments>> getAppointments() {
    return datasource.getAppointments();
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(DateTime date) {
    return datasource.getAppointmentsByDate(date);
  }

  @override
  Future<void> updateAppointment(Appointments appointment) {
    return datasource.updateAppointment(appointment);
  }
}
