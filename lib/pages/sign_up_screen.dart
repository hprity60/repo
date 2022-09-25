import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/register/register_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerBloc = sl.get<RegisterBloc>();
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is RegisterLoaded) {
          Navigator.pushReplacementNamed(
              context, RouteNames.resetPasswordScreen);
          //Utils.showSnackBar(context, state.);
        }
      },
      child: Scaffold(
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
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  print(state);
                  if (state is RegisterLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      
                      registerBloc.add(RegisterUserEvent(
                          Email: emailController.text,
                          Password: passwordController.text,
                          FirstName: firstnameController.text,
                          LastName: lastnameController.text,
                        ));
                    },
                  );
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
          ),
        ),
      ),
    );
  }
}
