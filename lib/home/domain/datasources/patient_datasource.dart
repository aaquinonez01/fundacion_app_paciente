import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';

abstract class PatientDatasource {
  Future<Patient> getPatient(String id);
  Future<Patient> createPatient(Patient patient);
}
