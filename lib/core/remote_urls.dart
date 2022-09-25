class RemoteUrls {
  static const String rootUrl = "https://api.chakri.app/";
  static const String baseUrl = "${rootUrl}api/v1/";
  static const String userRegister = '${baseUrl}user/create-jobseeker';
  static const String userLogin = '${baseUrl}auth/token';
  static const String verifyUser = '${baseUrl}user/verify';
  static const String sendForgetPassword = baseUrl + 'send-forget-password';
  static const String resendRegisterCode = baseUrl + 'resend-register-code';
  static String storeResetSassword(String code) =>
      baseUrl + 'store-reset-password/$code';

  static String userProfile(String token) =>
      baseUrl + 'user/my-profile?token=$token';
}
