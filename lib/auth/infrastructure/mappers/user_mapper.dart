import 'package:fundacion_paciente_app/auth/domain/entities/role_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_information_entities.dart';
import 'package:fundacion_paciente_app/auth/domain/entities/user_role_entities.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        username: json['username'] ?? '', // Manejo de posibles nulos
        isActive: json['isActive'] ?? false, // Asegura valores predeterminados
        userInformation: UserInformation(
          firstName: json['userInformation']['firstName'] ?? '',
          lastName: json['userInformation']['lastName'] ?? '',
          address: json['userInformation']['address'] ?? '',
          phone: json['userInformation']['phone'] ?? '',
          id: json['userInformation']['id'] ?? '',
        ),
        id: json['id'] ?? '',
        patientID: json['patientID'] ?? '',
        email: json['email'] ?? '',
        token: json['token'] ?? '',
        userRoles: json['userRoles'] != null
            ? (json['userRoles'] as List<dynamic>)
                .map<UserRole>((role) => UserRole(
                      role: Role(
                        name:
                            role.toString(), // `role` es un String directamente
                      ),
                    ))
                .toList()
            : [], // Lista vacía si `userRoles` es nulo // Lista vacía si `userRoles` es nulo
      );
}
