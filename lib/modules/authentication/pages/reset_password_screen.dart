import 'dart:io' show Platform;

import '../../../utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/router_name.dart';

import '../../../utils/utils.dart';
import '../blocs/reset_password/reset_password_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resetPasswordBloc = sl.get<ResetPasswordBloc>();
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is ResetPasswordLoaded) {
          Navigator.pushNamed(context, RouteNames.userProfileScreen);
          Utils.successSnackBar(context, "Your password has been reset successfully.");
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
                Platform.isAndroid
                    ? Icons.arrow_back
                    : Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: resetPasswordBloc.resetFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Reset Your Password!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 90),
                      TextFormField(
                        controller: codeController,
                        decoration: const InputDecoration(
                            hintText: 'Enter Verification Code'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Email'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Password'),
                      ),
                      const SizedBox(height: 50),
                      BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              child: const Text('Reset Password'),
                              onPressed: () {
                                resetPasswordBloc.add(ResetUserPasswordEvent(
                                  code: codeController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
