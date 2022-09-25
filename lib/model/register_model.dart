import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterModel {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  RegisterModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstname: json['FirstName'],
      lastname: json['LastName'],
      email: json['Email'],
      password: json['Password'],
    );
  }

}
