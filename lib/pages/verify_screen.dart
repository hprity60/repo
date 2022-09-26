import 'dart:convert';
import 'package:auth_app/bloc/verify/verify_bloc.dart';
import 'package:auth_app/core/pref.dart';
import 'package:auth_app/model/verify_user.dart';
import 'package:auth_app/pages/login_screen.dart';
import 'package:auth_app/pages/user_profile_screen.dart';
import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Future<VerifyUserModel> verifyUser(
  //     String email, password, firstName, lastName) async {

  //   print(Preference.getTokenFlag());
  //   final http.Response response = await http.post(
  //     Uri.parse(RemoteUrls.verifyUser),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           'Bearer ${Preference.getTokenFlag()} ', // daran.. logout banai
  //     },
  //     body: jsonEncode(<String, String>{
  //       // bujc logout korle sob clear kore diba logout to chai naijodi bole. okk
  //       'Email': email,
  //       'Password': password,
  //       'FirstName': firstName,
  //       'LastName': lastName,
  //     }),
  //   ); // verify hocce na
  //   print(response.statusCode);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final verifyResponse =
  //         VerifyUserModel.fromJson(json.decode(response.body));

  //     return verifyResponse;
  //   } else {
  //     throw Exception('failed!');
  //   }
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final verifyBloc = sl.get<VerifyBloc>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter First name';
                }
                return null;
              },
              controller: firstnameController,
              decoration: const InputDecoration(hintText: 'Enter First name'),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Last name';
                }
                return null;
              },
              controller: lastnameController,
              decoration: const InputDecoration(hintText: 'Enter last name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter email';
                } else if (!Utils.isEmail(value.trim())) {
                  return "Enter valid email";
                }
                return null;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Password';
                } else if (value.length < 8) {
                  return 'Enter atleaset 8 Character password';
                }

                return null;
              },
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Enter Password'),
            ),
            BlocBuilder<VerifyBloc, VerifyState>(
              builder: (context, state) {
                return ElevatedButton(
                  child: const Text('Verify'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const UserProfileScreen(),
                        ),
                      );
                      verifyBloc.add(
                        VerifyUserEvent(
                          Email: emailController.text,
                          Password: passwordController.text,
                          FirstName: lastnameController.text,
                          LastName: lastnameController.text,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
