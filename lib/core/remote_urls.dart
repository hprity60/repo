class RemoteUrls {
  static const String rootUrl = "https://api.chakri.app/";
  static const String baseUrl = "${rootUrl}api/v1/";
  static const String userRegister = '${baseUrl}user/create-jobseeker';
  static const String userLogin = '${baseUrl}auth/token';
  static const String verifyUser = '${baseUrl}user/verify';
  static const String forgetPassword = '${baseUrl}auth/forgot-password';
  static const String forget = 'auth/forgot-password';
  static const String resetPassworde = '${baseUrl}auth/reset-password';
}
