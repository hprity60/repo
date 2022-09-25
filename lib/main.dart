import 'package:auth_app/core/pref.dart';
import 'package:auth_app/pages/login_screen.dart';
import 'package:auth_app/pages/registration_screen.dart';
import 'package:auth_app/pages/sign_up_screen.dart';
import 'package:auth_app/pages/user_profile_screen.dart';
import 'package:auth_app/pages/verify_screen.dart';
import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:auth_app/utils/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'core/router_name.dart';

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
    // return  MaterialApp(
    //   home: Preference.getLoggedInFlag() ? UserProfileScreen() : RegistrationScreen(),

    // );

    return MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(AuthRepositoryIml()),
            child: SignUpScreen(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(AuthRepositoryIml()),
            child: LoginScreen(),
          ),
        ],
        child: MaterialApp(
          title: 'Auth Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: RouteNames.generateRoute,
          initialRoute: RouteNames.registrationScreen,
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
        ));
    //      // home: RegistrationScreen(),

    // }
  }

// token
// 0SgWtMPH6s0fALzur0uYNvRx64mwbEG4IayVbLZQDHCPtK82R1Nj7rCgRZ2VHbxuQ-KsEnxaM0peAIt5zVbr8SVrrqSyV6IBOB4HdcMGmGOQvtIvnmATvXO_g-bdYEEI51LoZi_U-Dq8FtnDept6p5tLzPrCwq6jBUbjZr-ZMk7Ys6h23WxfsH1izfLL0xY8F1GNaCeqH87RDBM5NohFji1OWpOTl51zUmHAlOzUNBPWSpUTk0xafVh6j0eRZRJR8xBZWIn1HEk1WNln-5ylqwZdgVTyi_7wZZgU9kAlkjQRg69wdRxSYcY0MYqy6rn3l48ZQfovAa1gYGuQuXxbXbHGS4VkKfOMisEcCW02Fd_Ofey36YUpxRKHvWcOaFKEtDRkFODFpc0MxVFcGL7aIA
// b@gmail.com

}
