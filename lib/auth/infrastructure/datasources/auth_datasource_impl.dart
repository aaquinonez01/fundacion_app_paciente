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
      print(response.data);
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
  Future<bool> register(RequestData userRegister) async {
    try {
      print(userRegister.toJson());
      final response =
          await dio.post('/auth/register', data: userRegister.toJson());
      print(response.data);
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print(e.response?.data['message']);
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.response?.statusCode == 400) {
        print(e.response?.data['message']);
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      if (e.response?.statusCode == 404) {
        print(e.response?.data['message']);
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la Peticion');
      }

      if (e.response?.statusCode == 500) {
        print(e.response?.data['message']);
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la Peticion');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        print("Error de conexión");
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
      if (e.response?.statusCode == 400) {
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

  @override
  Future<void> resetPassword(
      String email, String token, String newPassword) async {
    try {
      final response =
          await dio.patch('/auth/update-password-with-email', data: {
        'email': email,
        'confirmPassword': newPassword,
        'newPassword': newPassword,
        'token': token
      });
      print("response: ${response}");
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("Error: ${e.response?.data}");
        throw CustomError('Token incorrecto');
      }
      if (e.response?.statusCode == 400) {
        print("Error: ${e.response?.data}");
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }

      if (e.response?.statusCode == 500) {
        print("Error: ${e.response?.data}");
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      print("Error: ${e.response?.data}");
      throw CustomError(
        'Error no controlado',
      );
    } catch (e) {
      print("Error: $e");
      throw CustomError(
        'Error no controlado',
      );
    }
  }

  @override
  Future<void> sendCode(String email) async {
    try {
      final response =
          await dio.post('/auth/reset-password', data: {'email': email});
      print(response);
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
  Future<void> validateCode(String email, String code) async {
    try {
      print(code);
      final response = await dio
          .post('/token/verify', data: {'email': email, 'token': code});

      print("response: ${response.data}");

      if (response.statusCode == 201) {
        print("Código validado correctamente");
        return;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("Error: ${e.response?.data}");
        throw CustomError('Token incorrecto');
      }
      if (e.response?.statusCode == 400) {
        print("Error: ${e.response?.data}");
        throw CustomError(
            e.response?.data['message'] ?? 'Error en la petición');
      }
      print("Error: ${e.response?.data}");
      throw Exception(
        'Error no controlado',
      );
    } catch (e) {
      print("Error: $e");
      throw Exception(
        'Error no controlado',
      );
    }
  }
}
