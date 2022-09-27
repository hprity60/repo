import '../../../utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/verify/verify_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verifyBloc = sl.get<VerifyBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocBuilder<VerifyBloc, VerifyState>(
            builder: (context, state) {
              if (state is VerifyLoading) {
                return const CircularProgressIndicator();
              }
              if (state is VerifyFailed) {
                return Text(state.errorMsg);
              }
              if (state is VerifyLoaded) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "User name: ${state.firstName}",
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            " ${state.lastName}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      Text(
                        "Email: ${state.email}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
