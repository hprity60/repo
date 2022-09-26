import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register/sign_up_bloc.dart';
import '../core/router_name.dart';
import '../utils/utils.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpBloc = sl.get<SignUpBloc>();
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is SignUpLoaded) {
          Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          // Utils.showSnackBar(context, state.);
        }
      },
      child: Scaffold(
        body: Form(
          key: signUpBloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: (value) => signUpBloc.add(
                    SignUpEventFirstNameChanged(
                        firstName: firstnameController.text)),
                controller: firstnameController,
                decoration: const InputDecoration(hintText: 'Enter First name'),
              ),
              TextFormField(
                onChanged: (value) => signUpBloc.add(SignUpEventLastNameChanged(
                    lastName: lastnameController.text)),
                controller: lastnameController,
                decoration: const InputDecoration(hintText: 'Enter last name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Enter Email'),
                onChanged: (value) => signUpBloc
                    .add(SignUpEventEmailChanged(email: emailController.text)),
              ),
              TextFormField(
                onChanged: (value) => signUpBloc.add(SignUpEventPasswordChanged(
                    password: passwordController.text)),
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Enter Password'),
              ),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  print(state);
                  if (state is SignUpLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () {
                          signUpBloc.add(
                            SignUpEventSubmit(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: firstnameController.text,
                              lastName: lastnameController.text,
                            ),
                          );
                        });
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Login Now'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
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
          ),
        ),
      ),
    );
  }
}
