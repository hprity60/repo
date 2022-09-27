import 'dart:io' show Platform;

import '../../../utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../blocs/sign_up/sign_up_bloc.dart';

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
          // Navigator.pushNamed(context, RouteNames.loginScreen);
          Navigator.pushNamed(context, RouteNames.loginScreen);
          Utils.successSnackBar(
              context, "You're account successfully created.");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: signUpBloc.signUpFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Create Your Account!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 90),
                  TextFormField(
                    controller: firstnameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter First name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: lastnameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter last name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'Enter Email'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Password'),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      print(state);
                      if (state is SignUpLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return ElevatedButton(
                            child: const Text('Sign Up'),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Have an account?  '),
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, RouteNames.loginScreen);
                        },
                        child: const Text(
                          'SignIn Now',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
