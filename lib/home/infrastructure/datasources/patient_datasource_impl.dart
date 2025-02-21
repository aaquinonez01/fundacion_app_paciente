import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';
import 'package:fundacion_paciente_app/home/domain/datasources/patient_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';
import 'package:fundacion_paciente_app/home/infrastructure/mappers/patient_mapper.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/services/key_value_storage_service_impl.dart';

class PatientDatasourceImpl implements PatientDatasource {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer '},
  ));

  Future<String?> _getToken() async {
    return await keyValueStorageService.getValue<String>('token');
  }

  Future<void> _setAuthorizationHeader() async {
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      print("Se estableció el token" + token);
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

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
  Future<Patient> getPatient(String id) async {
    try {
      await _setAuthorizationHeader();
      print("ID: $id");
      final response = await dio.get('/patients/$id');
      print(response.data);
      final patient = PatientMapper.patientJsonToEntity(response.data);
      print(patient.dni);
      return patient;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Necesitas iniciar sesión');
      }
      if (e.response?.statusCode == 403) {
        throw CustomError(e.response?.data['message'] ??
            'No tienes permisos para acceder a esta información');
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

      print("Error: $e");
      throw Exception(
        'Error no controlado',
      );
    } catch (e) {
      print("Error: " + e.toString());
      throw Exception();
    }
  }
}
