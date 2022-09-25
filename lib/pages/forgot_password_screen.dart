import 'package:auth_app/pages/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auth_app/core/pref.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  Future forgotPassword(String email) async {
    var headersList = {
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Accept': 'Accept: application/json',
      'Authorization':
          'Bearer ${Preference.getTokenFlag()}',
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

  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
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
            ElevatedButton(
              child: const Text('login'),
              onPressed: () {
                
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ResetPasswordScreen(),
                    ),
                  );
                  forgotPassword(emailController.text);
                }
              
            ),
          ],
        ),
      ),
    ));
  }
}
