import 'package:fundacion_paciente_app/auth/domain/entities/role_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_information_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_role_entities.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        username: json['username'],
        isActive: json['isActive'],
        userInformation: UserInformation(
          firstName: json['userInformation']['firstName'],
          lastName: json['userInformation']['lastName'],
          address: json['userInformation']['address'],
          phone: json['userInformation']['phone'],
          id: json['userInformation']['id'],
        ),
        id: json['id'],
        email: json['email'],
        token: json['token'],
        userRoles: json['userRoles']
            .map<UserRole>((role) => UserRole(role: Role(name: role['name'])))
            .toList(),
      );
}
