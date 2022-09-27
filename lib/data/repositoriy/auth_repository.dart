import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../core/error/exception.dart';
import '../../core/pref.dart';
import '../../core/remote_urls.dart';
import '../model/verify_user.dart';

abstract class AuthRepository {
  Future<bool> register(String email, password, firstName, lastName);
  Future login(String username, password);
  Future<VerifyUserModel> verifyUser(
      String email, password, firstName, lastName);
  Future forgotPassword(String email);
  Future resetPassword(String code, email, password);
}

class AuthRepositoryIml extends AuthRepository {
  // register user
  @override
  Future<bool> register(String email, password, firstName, lastName) async {
    final http.Response response = await http.post(
      Uri.parse(RemoteUrls.userRegister),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Password': password,
        'FirstName': firstName,
        'LastName': lastName,
      }),
    );
    print("Email: $email");
    print("Password: $password");
    print("FirstName: $firstName");
    print("LastName: $lastName");
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.body.isNotEmpty) {
      var item = const JsonDecoder().convert(response.body);
      print("item $item");
      print("Message ${item['Message']}");
      throw '${item['Message']}';
    } else if (response.statusCode == 10061) {
      throw 'No internet connection';
    } else if (response.statusCode == 408) {
      throw 'Request timed out';
    } else {
      return false;
    }
  }

  // printin
  @override
  Future login(String username, password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(RemoteUrls.userLogin));
    request.bodyFields = {
      'username': username,
      'password': password,
      'grant_type': 'password'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var item1 =
          const JsonDecoder().convert(await response.stream.bytesToString());
      print("item $item1");
      print("access_token ${item1['access_token']}");
      Preference.clearAll();
      Preference.setTokenFlag("${item1['access_token']}");
      return item1;
    } else {
      throw "Your email or password incorrect.";
    }
  }

  // // verify user
  // @override
  // Future<VerifyUserModel> verifyUser(
  //     String email, password, firstName, lastName) async {
  //   final http.Response response = await http.post(
  //     Uri.parse(RemoteUrls.verifyUser),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer ${Preference.getTokenFlag()}',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'Email': email,
  //       'Password': password,
  //       'FirstName': firstName,
  //       'LastName': lastName,
  //     }),
  //   );
  //   print(response.statusCode);
  //   print(response.body);

  //   var item = const JsonDecoder().convert(response.body);
  //   log("item $item");
  //   log("Message ${item['Message']}");

  //   if (response.statusCode == 200) {
  //     final verifyResponse =
  //         VerifyUserModel.fromJson(json.decode(response.body));

  //     return verifyResponse;
  //   } else {
  //     throw 'Your email or password incorrect!';
  //   }
  // }

// verify user
  @override
  Future<VerifyUserModel> verifyUser(
      String email, password, firstName, lastName) async {
    final http.Response response = await http.post(
      Uri.parse(RemoteUrls.verifyUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Preference.getTokenFlag()}',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Password': password,
        'FirstName': firstName,
        'LastName': lastName,
      }),
    );
    print(response.statusCode);
    log(response.body);

    var item = const JsonDecoder().convert(response.body);
    log("item $item");
    log("Message ${item['Message']}");
    return _responseParser(response);
    // if (response.statusCode == 200) {
    //   final verifyResponse =
    //       VerifyUserModel.fromJson(json.decode(response.body));

    //   return verifyResponse;
    // } else {
    //   throw 'Your email or password incorrect!';
    // }
  }

  // forgot password
  @override
  Future forgotPassword(String email) async {
    var headersList = {
      'Accept': 'Accept: application/json',
      'Authorization': 'Bearer ${Preference.getTokenFlag()}',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var url = Uri.parse(RemoteUrls.forgetPassword);

    var body = {'Email': email};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.bodyFields = body;

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      log(resBody);
    } else {
      throw 'Your email is incorrect!';
    }
  }

  // reset password
  @override
  Future resetPassword(String code, email, password) async {
    var headersList = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${Preference.getTokenFlag()}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(RemoteUrls.resetPassworde);

    var body = {
      "Code": code,
      "Email": email,
      "Password": password,
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      log(resBody);
    } else if (res.statusCode == 10061) {
      throw 'No internet connection';
    } else if (res.statusCode == 408) {
      throw 'Request timed out';
    } else {
      throw 'Your Code is incorrect!';
    }
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

        ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

        /// 415 Unsupported Media Type
        throw const DataFormateException('Data formate exception');

      case 500:

        ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occured while communication with Server',
            response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: '');
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: '');
    }
    return 'Credentials does not match';
  }
}
