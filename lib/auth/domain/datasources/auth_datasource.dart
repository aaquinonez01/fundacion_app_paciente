//Class abstract AuthDatasource
import 'package:fundacion_paciente_app/auth/domain/entities/user_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_register.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<User> register(RequestData user);
  Future<User> checkAuthStatus(String token);
}
