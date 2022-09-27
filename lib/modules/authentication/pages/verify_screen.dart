import 'dart:io' show Platform;

import '../../../utils/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../blocs/verify/verify_bloc.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final verifyBloc = sl.get<VerifyBloc>();
    return BlocListener<VerifyBloc, VerifyState>(
      listener: (context, state) {
        if (state is VerifyFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is VerifyLoaded) {
          Navigator.pushNamed(context, RouteNames.userProfileScreen);
          Utils.successSnackBar(
              context, "Your account successfully verified!");
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
            key: verifyBloc.verifyFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Verify Your Account!',
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
                        const InputDecoration(hintText: 'Enter Last name'),
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
                  const SizedBox(height: 50),
                  BlocBuilder<VerifyBloc, VerifyState>(
                    builder: (context, state) {
                      if (state is VerifyLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        child: const Text('Verify'),
                        onPressed: () {
                          verifyBloc.add(
                            VerifyEventSubmit(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: lastnameController.text,
                              lastName: lastnameController.text,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
