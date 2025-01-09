// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

class UserRegister {
  String email;
  String password;
  String username;
  UserInformationRegister userInformation;

  UserRegister({
    required this.email,
    required this.password,
    required this.username,
    required this.userInformation,
  });

  //toJson
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
        "userInformation": userInformation.toJson(),
      };
}

class UserInformationRegister {
  String firstname;
  String lastname;
  String address;
  String phone;

  UserInformationRegister({
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phone,
  });

  //toJson
  Map<String, dynamic> toJson() => {
        "firstName": firstname,
        "lastName": lastname,
        "address": address,
        "phone": phone,
      };
}
