import 'package:auth_app/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:auth_app/pages/reset_password_screen.dart';
import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router_name.dart';
import '../utils/utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordBloc = sl.get<ForgotPasswordBloc>();
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is ForgotPasswordLoaded) {
          Navigator.pushReplacementNamed(context, RouteNames.resetPasswordScreen);
          // Utils.showSnackBar(context, state.);
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: Form(
          key: forgotPasswordBloc.formKey,
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
                decoration: const InputDecoration(hintText: 'Enter Email'),
              ),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  print(state);
                  if (state is ForgotPasswordLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                      child: const Text('Forgot Password'),
                      onPressed: () {
                        forgotPasswordBloc.add(
                          ForgotUserPasswordEvent(
                            Email: emailController.text,
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
