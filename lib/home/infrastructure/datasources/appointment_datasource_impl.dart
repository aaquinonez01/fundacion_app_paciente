import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';
import 'package:fundacion_paciente_app/home/domain/datasources/appointment_datasource.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
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
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  @override
  Future<void> createAppointment(Appointments appointment) {
    // TODO: implement createAppointment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAppointment(Appointments appointment) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Appointments>> getAppointmentsByStatus(String status) async {
    print('getAppointmentsByStatus  $status');
    await _setAuthorizationHeader();
    final response =
        await dio.get('/appointments/find-by-status?status=$status');
    print("response: ${response.data['data']}");
    final appointments = (response.data['data'] as List)
        .map((appointment) => Appointments.fromJson(appointment))
        .toList();
    print("appointments: $appointments");
    return appointments;
  }

  @override
  Future<void> updateAppointment(Appointments appointment) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }
}
