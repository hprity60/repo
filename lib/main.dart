import 'utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'core/router_name.dart';
import 'modules/authentication/blocs/forgot_password/forgot_password_bloc.dart';
import 'modules/authentication/blocs/login/login_bloc.dart';
import 'modules/authentication/blocs/reset_password/reset_password_bloc.dart';
import 'modules/authentication/blocs/sign_up/sign_up_bloc.dart';
import 'modules/authentication/blocs/verify/verify_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<SignUpBloc>(),
        ),
        BlocProvider(
          create: (context) => sl.get<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => sl.get<VerifyBloc>(),
        ),
        BlocProvider(
          create: (context) => sl.get<ForgotPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => sl.get<ResetPasswordBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Auth App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: RouteNames.generateRoute,
        initialRoute: RouteNames.loginScreen,
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
        },
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
