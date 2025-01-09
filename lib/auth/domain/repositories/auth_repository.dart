import 'package:fundacion_paciente_app/auth/domain/entities/user_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(UserRegister user);
  Future<User> checkAuthStatus(String token);
}
