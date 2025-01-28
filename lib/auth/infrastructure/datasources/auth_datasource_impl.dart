import 'package:fundacion_paciente_app/auth/domain/datasources/auth_datasource.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_entities.dart';
import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_register.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/mappers/user_mapper.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));
  @override
  Future<User> checkAuthStatus(String token) async {
    print(token);
    try {
      final response = await dio.get('/auth/check-status',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(RequestData userRegister) async {
    try {
      print(userRegister.toJson());
      final response =
          await dio.post('/auth/register', data: userRegister.toJson());
      print(response.data);
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.response?.statusCode == 400) {
        print(e.response?.data['message']);
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }

      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la Peticion');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      print("Error: $e");
      throw Exception();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Error en la conexión');
      }
      print("Error: $e");
      throw Exception();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
