import 'dart:convert';
import 'package:intl/intl.dart';

class UserInformation {
  final String firstname;
  final String lastname;
  final String address;
  final String phone;

  UserInformation({
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'phone': phone,
    };
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}

class CreateUser {
  final String email;
  final String password;
  final String username;
  final UserInformation userInformation;

  CreateUser({
    required this.email,
    required this.password,
    required this.username,
    required this.userInformation,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'userInformation': userInformation.toMap(),
    };
  }
}

class CreatePatient {
  final String firstname;
  final String lastname;
  final String birthdate;
  final String legalGuardian;
  final String dni;
  final List<String> disability;
  final String gender;
  final String relationshipRepresentativePatient;
  final String healthInsurance;
  final List<String> currentMedications;
  final List<String> allergies;
  final List<String> historyTreatmentsReceived;

  CreatePatient({
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.legalGuardian,
    required this.dni,
    required this.disability,
    required this.gender,
    required this.relationshipRepresentativePatient,
    required this.healthInsurance,
    required this.currentMedications,
    required this.allergies,
    required this.historyTreatmentsReceived,
  });

  Map<String, dynamic> toMap() {
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final DateTime parsedDate = inputFormat.parse(birthdate);
    return {
      'firstname': firstname,
      'lastname': lastname,
      'birthdate': (parsedDate).toIso8601String(),
      'legalGuardian': legalGuardian,
      'dni': dni,
      'disability': disability,
      'gender': gender,
      'relationshipRepresentativePatient': relationshipRepresentativePatient,
      'healthInsurance': healthInsurance,
      'currentMedications': currentMedications,
      'allergies': allergies,
      'historyTreatmentsReceived': historyTreatmentsReceived,
    };
  }
}

class RequestData {
  final CreateUser createUser;
  final CreatePatient createPatient;

  RequestData({
    required this.createUser,
    required this.createPatient,
  });

  Map<String, dynamic> toJson() {
    return {
      'createUser': createUser.toMap(),
      'createPatient': createPatient.toMap(),
    };
  }
}
