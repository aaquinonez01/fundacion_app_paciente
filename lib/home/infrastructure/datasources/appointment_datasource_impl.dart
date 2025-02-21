import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';
import 'package:fundacion_paciente_app/home/domain/datasources/appointment_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/entities/registerCita.entity.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/services/key_value_storage_service_impl.dart';

class AppointmentDatasourceImpl implements AppointmentDatasource {
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
      print("token: $token");
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  @override
  Future<void> createAppointment(CreateAppointments appointment) async {
    try {
      print(appointment.toJson());
      await _setAuthorizationHeader();
      final response =
          await dio.post('/appointments', data: appointment.toJson());
      print("response: ${response.data}");

      if (response.statusCode == 201) {
        print("Cita creada correctamente");
        return;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      if (e.response?.statusCode == 400) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      print("Error: ${e.response?.data}");
      throw Exception(
        'Error no controlado',
      );
    } catch (e) {
      print(e.toString());
      print("Error: $e");
      throw Exception(
        'Error no controlado',
      );
    }
  }

  @override
  Future<void> deleteAppointment(Appointments appointment) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future<void> updateAppointment(Appointments appointment) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Appointments>> getAppointmentsByDate(DateTime date) async {
    try {
      await _setAuthorizationHeader();
      print("date: $date");
      final response = await dio
          .get('/appointments/find-all-by-patient-and-date?date=$date');
      final appointments = (response.data['data'] as List)
          .map((appointment) => Appointments.fromJson(appointment))
          .toList();
      print("appointments: $appointments");
      return appointments;
    } catch (e) {
      final error = e as DioError;
      if (error.response?.statusCode == 401) {
        print(
            "error: ${error.response?.data['message'] ?? 'Token incorrecto'}");
        throw CustomError(
            error.response?.data['message'] ?? 'Token incorrecto');
      }
      if (error.response?.statusCode == 403) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(error.response?.data['message'] ??
            'No tienes permisos para realizar esta acción');
      }
      if (error.response?.statusCode == 400) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(
            error.response?.data['message'] ?? 'Error en la petición');
      }
      if (error.response?.statusCode == 404) {
        throw CustomError(
            error.response?.data['message'] ?? 'No hay citas para esta fecha');
      }
      if (error.response?.statusCode == 500) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(
            error.response?.data['message'] ?? 'Error en el servidor');
      }

      throw CustomError(
        error.response?.data['message'] ?? 'Error no controlado',
      );
    }
  }

  @override
  Future<List<Appointments>> getAppointments() async {
    print(dio.options.baseUrl);
    try {
      await _setAuthorizationHeader();
      final response = await dio.get('/appointments/find-by-all-patient');
      final appointments = (response.data['data'] as List)
          .map((appointment) => Appointments.fromJson(appointment))
          .toList();
      print("appointments: $appointments");
      return appointments;
    } catch (e) {
      final error = e as DioError;
      if (error.response?.statusCode == 401) {
        print(
            "error: ${error.response?.data['message'] ?? 'Token incorrecto'}");
        throw CustomError(
            error.response?.data['message'] ?? 'Token incorrecto');
      }
      if (error.response?.statusCode == 403) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(error.response?.data['message'] ??
            'No tienes permisos para realizar esta acción');
      }
      if (error.response?.statusCode == 400) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(
            error.response?.data['message'] ?? 'Error en la petición');
      }
      if (error.response?.statusCode == 404) {
        throw CustomError(
            error.response?.data['message'] ?? 'No hay citas para esta fecha');
      }
      if (error.response?.statusCode == 500) {
        print("error: ${error.response?.data['message']}");
        throw CustomError(
            error.response?.data['message'] ?? 'Error en el servidor');
      }

      throw CustomError(
        error.response?.data['message'] ?? 'Error no controlado',
      );
    }
  }
}
