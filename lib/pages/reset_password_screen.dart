import 'package:auth_app/bloc/reset_password/reset_password_bloc.dart';
import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_app/core/router_name.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  // Future resetPassword(String code, email, password) async {
  //   var headersList = {
  //     'Accept': '*/*',
  //     'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
  //     'Authorization':
  //         'Bearer ${Preference.getTokenFlag()}',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('https://api.chakri.app/api/v1/auth/reset-password');

  //   var body = {
  //     "Code": code,
  //     "Email": email,
  //     "Password": password
  //   };

  //   var req = http.Request('POST', url);
  //   req.headers.addAll(headersList);
  //   req.body = json.encode(body);

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     print(resBody);
  //   } else {
  //     print(res.reasonPhrase);
  //   }
  // }

  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resetPasswordBloc = sl.get<ResetPasswordBloc>();
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: codeController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Verification Code';
                }
                return null;
              },
              decoration:
                  const InputDecoration(hintText: 'Enter Verification Code'),
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Email';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Enter Email'),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Password';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Enter Password'),
            ),
            BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
              builder: (context, state) {
                return ElevatedButton(
                    child: const Text('Reset Password'),
                    onPressed: () {
                      resetPasswordBloc.add(ResetUserPasswordEvent(
                        codeController.text,
                        emailController.text,
                        passwordController.text,
                      ));
                      Navigator.pushNamed(context, RouteNames.userProfileScreen);
                    });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
