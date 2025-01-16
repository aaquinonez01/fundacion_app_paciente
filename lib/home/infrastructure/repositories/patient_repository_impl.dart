import 'package:fundacion_paciente_app/home/domain/datasources/patient_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/patient_repository.dart';
import 'package:fundacion_paciente_app/home/infrastructure/datasources/patient_datasource_impl.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDatasource patientDatasource;

  PatientRepositoryImpl({PatientDatasource? patientDatasource})
      : patientDatasource = patientDatasource ?? PatientDatasourceImpl();
  @override
  Future<Patient> createPatient(Patient patient) {
    return patientDatasource.createPatient(patient);
  }

  @override
  Future<Patient> getPatient(String id) {
    return patientDatasource.getPatient(id);
  }
}
