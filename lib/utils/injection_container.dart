import 'package:get_it/get_it.dart';

import '../data/repositoriy/auth_repository.dart';
import '../modules/authentication/blocs/forgot_password/forgot_password_bloc.dart';
import '../modules/authentication/blocs/login/login_bloc.dart';
import '../modules/authentication/blocs/reset_password/reset_password_bloc.dart';
import '../modules/authentication/blocs/sign_up/sign_up_bloc.dart';
import '../modules/authentication/blocs/verify/verify_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {
  sl.registerSingleton(SignUpBloc(AuthRepositoryIml()));
  sl.registerSingleton(LoginBloc(AuthRepositoryIml()));
  sl.registerSingleton(VerifyBloc(AuthRepositoryIml()));
  sl.registerSingleton(ForgotPasswordBloc(AuthRepositoryIml()));
  sl.registerSingleton(ResetPasswordBloc(AuthRepositoryIml()));
}
