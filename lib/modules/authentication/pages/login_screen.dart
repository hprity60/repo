import '../../../core/router_name.dart';
import '../../../utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../blocs/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = sl.get<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          Utils.errorSnackBar(context, state.errorMsg);
        } else if (state is LoginLoaded) {
          Navigator.pushNamed(context, RouteNames.verifyScreen);
          Utils.successSnackBar(context, "Your successfully logged in.");
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: loginBloc.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 90),

                const Text(
                  'Welcome here!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 90),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter password',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.forgotPasswordScreen);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    print(state);
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      child: const Text('Sign In'),
                      onPressed: () {
                        loginBloc.add(
                          LoginEventSubmit(
                            username: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have no account?  '),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, RouteNames.signUpScreen);
                      },
                      child: const Text(
                        'SignUp Now',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
                // ElevatedButton(
                //   child: const Text('Verify'),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (_) => VerifyScreen(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
