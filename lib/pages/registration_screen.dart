// import 'package:auth_app/pages/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/register/register_bloc.dart';

// class RegistrationScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController fnameController = TextEditingController();
//   final TextEditingController lnameController = TextEditingController();

//   RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final registerBloc = BlocProvider.of<RegisterBloc>(context);

//     return Scaffold(
//       body: BlocBuilder<RegisterBloc, RegisterState>(
//         builder: (context, state) {
//           print(state);
//           if (state is RegisterLoading) {
//             return CircularProgressIndicator();
//           } else if (state is RegisterLoaded) {
//             return Column(
//               children: [
//                 const SizedBox(height: 50),
//                 TextFormField(
//                   controller: fnameController,
//                 ),
//                 TextField(
//                   controller: lnameController,
//                 ),
//                 TextField(
//                   controller: emailController,
//                 ),
//                 TextField(
//                   controller: passwordController,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     registerBloc.add(RegisterUserEvent(
//                         FirstName: fnameController.text,
//                         LastName: lnameController.text,
//                         Email: emailController.text,
//                         Password: passwordController.text));
//                   },
//                   child: const Text('Register'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                   child: const Text('Login now'),
//                 ),
//               ],
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:auth_app/core/pref.dart';
import 'package:auth_app/pages/forgot_password_screen.dart';
import 'package:auth_app/pages/login_screen.dart';
import 'package:auth_app/pages/reset_password_screen.dart';
import 'package:http/http.dart' as http;
import 'package:auth_app/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../core/remote_urls.dart';
import '../model/check.dart';
import '../model/verify_user.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Future<RegisterModel>? registerUser;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<RegisterModel> register(
      String email, password, firstName, lastName) async {
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

    // Dispatch action depending upon
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return RegisterModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        // ignore: unnecessary_null_comparison
        child: registerUser == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: firstnameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter First name'),
                  ),
                  TextField(
                    controller: lastnameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter last name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Enter Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Password'),
                  ),
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      setState(() {
                        registerUser = register(
                          emailController.text,
                          passwordController.text,
                          firstnameController.text,
                          lastnameController.text,
                        );
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Login Now'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Forgot password?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Reset password?'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResetPasswordScreen(),
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
              )
            : 
            FutureBuilder<RegisterModel>(
                future: registerUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(snapshot.data!.firstname),
                        Text(snapshot.data!.lastname),
                        Text(snapshot.data!.email),
                        Text(snapshot.data!.password),
                        TextButton(
                            onPressed: () {
                              // acca, reload dile user info jaiga... mane user k bar bar login korte hobe.. etar solution ki..
                              // ekbar login hole jno r login korar drkr na hoi... logged in iii thkbe , aitar jonno 
                              Preference.clearAll();

                            },  // acca bujlam
                            child: const Text('Logout')),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                },
              ),
            // FutureBuilder<RegisterModel>(
            //     future: registerUser,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Column(
            //           children: [
            //             Text(snapshot.data!.firstname),
            //             Text(snapshot.data!.lastname),
            //             Text(snapshot.data!.email),
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
