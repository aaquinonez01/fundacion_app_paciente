import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';
import 'package:fundacion_paciente_app/home/domain/datasources/patient_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';
import 'package:fundacion_paciente_app/home/infrastructure/mappers/patient_mapper.dart';

class PatientDatasourceImpl implements PatientDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));
  @override
  Future<Patient> createPatient(Patient patient) async {
    try {
      final response = await dio.post('/patients', data: patient.toJson());
      final patientData = PatientMapper.patientJsonToEntity(response.data);
      return patientData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Necesitas iniciar sesión');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError('Error en el servidor, intenta más tarde');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

//TODO: Implementar el método getPatient correctamente con el id del representante
  @override
  Future<Patient> getPatient(String id) {
    try {
      return dio.get('/patients/$id').then((response) {
        final patient = PatientMapper.patientJsonToEntity(response.data);
        return patient;
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Necesitas iniciar sesión');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError('Error en el servidor, intenta más tarde');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
