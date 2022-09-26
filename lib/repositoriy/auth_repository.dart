import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/pref.dart';
import '../core/remote_urls.dart';
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
    print(email);
    print(password);
    print(firstName);
    print(lastName);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('failed!');
    }
  }

  // login
  @override
  Future login(String username, password) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://api.chakri.app/api/v1/auth/token'));
    request.bodyFields = {
      'username': username,
      'password': password,
      'grant_type': 'password'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var item =
          const JsonDecoder().convert(await response.stream.bytesToString());
      print("item $item");
      print("access_token ${item['access_token']}");
      Preference.clearAll();
      Preference.setTokenFlag("${item['access_token']}");
      return item;
    } else {
      print(response.reasonPhrase);
      throw Exception();
    }
  }

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
      //print("${Preference.getTokenFlag()}") // verify
      body: jsonEncode(<String, String>{
        'Email': email,
        'Password': password,
        'FirstName': firstName,
        'LastName': lastName,
      }),
    );

    // Dispatch action depending upon
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final verifyResponse =
          VerifyUserModel.fromJson(json.decode(response.body));

      return verifyResponse;
    } else {
      throw Exception('failed!');
    }
  }

  // forgot password
  @override
  Future forgotPassword(String email) async {
    var headersList = {
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Accept': 'Accept: application/json',
      'Authorization': 'Bearer ${Preference.getTokenFlag()}',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var url = Uri.parse('https://api.chakri.app/api/v1/auth/forgot-password');

    var body = {'Email': email};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.bodyFields = body;

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  // reset password
  @override
  Future resetPassword(String code, email, password) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer ${Preference.getTokenFlag()}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://api.chakri.app/api/v1/auth/reset-password');

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
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
