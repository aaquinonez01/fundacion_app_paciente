import 'package:fundacion_paciente_app/auth/domain/entities/user_information_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_role_entities.dart';

class User {
  String id;
  String email;
  String username;
  bool isActive;
  UserInformation userInformation;
  List<UserRole> userRoles;
  String token;
  String patientID;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.userInformation,
    required this.userRoles,
    required this.token,
    required this.patientID,
  });
}
