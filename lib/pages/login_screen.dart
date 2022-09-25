import 'dart:convert';

import 'package:auth_app/bloc/login/login_bloc.dart';
import 'package:auth_app/core/pref.dart';
import 'package:auth_app/pages/verify_screen.dart';
import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Future<LoginResponseModel> post(String userName, passWord) async {
  //   var payloadObj = {
  //     "userName": userName,
  //     "password": passWord,
  //     "grant_type": 'password',
  //   };

  //   var uri = Uri.parse('https://api.chakri.app/api/v1/auth/token');
  //   var payload = json.encode(payloadObj);

  //   var response = await http.post(
  //     uri,
  //     body: payload,
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   ).timeout(
  //     const Duration(seconds: 10),
  //   );
  //   print(response.body);
  //   print(response.statusCode);

  //   return LoginResponseModel.fromJson(json.decode(response.body));
  // }

  // login(String username, password) async {
  //   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   var request = http.Request(
  //       'POST', Uri.parse('https://api.chakri.app/api/v1/auth/token'));
  //   request.bodyFields = {
  //     'username': username,
  //     'password': password,
  //     'grant_type': 'password'
  //   };
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var item =
  //         const JsonDecoder().convert(await response.stream.bytesToString());
  //     print("item $item");
  //     print("access_token ${item['access_token']}");
  //     Preference.clearAll();
  //     Preference.setTokenFlag("${item['access_token']}");
  //     Preference.setLoggedInFlag(true);
  //     print('token');
  //     print(Preference.getTokenFlag());
  //     return item;
  //   } else {
  //     print(response.reasonPhrase);
  //     throw Exception();
  //   }

  //   // Dispatch action depending upon
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = sl.get<LoginBloc>();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          // ignore: unnecessary_null_comparison
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Email';
                    }
                    return null;
                  },
                  // validator: (val) {
                  //   if (val.isValidName) {
                  //     return 'Enter valid email';
                  //   }
                  //   return null;
                  // },
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                ),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Password Required" : null;
                  },
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Password',
                  ),
                ),
                ElevatedButton(
                  child: const Text('login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const VerifyScreen(),
                        ),
                      );
                      loginBloc.add(
                        LoginUserEvent(
                          username: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Verify'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VerifyScreen(),
                      ),
                    );
                  },
                ),

                // RiisedButton is deprecated and shouldn't be used. Use ElevatedButton.

                // RaisedButton(
                //   child: Text('Create Data'),
                //   onPressed: () {
                //     setState(() {
                //       _futureAlbum = createAlbum(_controller.text);
                //     });
                //   },
                // ),
              ],
            ),
          )
          //  FutureBuilder<LoginResponseModel>(
          //     future: loginUser,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return Column(
          //           children: [
          //             Text(snapshot.data!.username),
          //             Text(snapshot.data!.password),
          //           ],
          //         );
          //       } else if (snapshot.hasError) {
          //         return Text("${snapshot.error}");
          //       }

          //       return const CircularProgressIndicator();
          //     },
          //   ),
          ),
    );
  }
}
