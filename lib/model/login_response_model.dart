// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponseModel {
  final String username;
  final String password;
  final String grantType;
  LoginResponseModel({
    required this.username,
    required this.password,
    required this.grantType,
  });
  

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      username: json['username'].toString(),
      password: json['password'].toString(),
      grantType: json['grant_type'].toString(),
    );
  }
}

//token khotay pacco?