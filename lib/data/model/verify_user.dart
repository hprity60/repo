// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyUserModel {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  VerifyUserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

factory VerifyUserModel.fromJson(Map<String, dynamic> json) {
    return VerifyUserModel(
      firstname: json['FirstName'],
      lastname: json['LastName'],
      email: json['Email'],
      password: json['Password']??'',
    );
  }

}
