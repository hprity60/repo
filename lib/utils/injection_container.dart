import 'package:auth_app/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:auth_app/bloc/login/login_bloc.dart';
import 'package:auth_app/bloc/register/sign_up_bloc.dart';
import 'package:auth_app/bloc/verify/verify_bloc.dart';
import 'package:auth_app/core/pref.dart';
import 'package:auth_app/core/router_name.dart';
import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:get_it/get_it.dart';

import '../bloc/reset_password/reset_password_bloc.dart';

// final getIt = GetIt.instance;

// Future<void> setupLocator() async {
//   _setupBlocs();
//   _setUpDataSources();
//   _setUpRepositories();
//   _setupCores();
// }

// //* Blocs
// void _setupBlocs() {
//   getIt.registerFactory(() => RegisterBloc(getIt()));
//   getIt.registerFactory(() => RegisterBloc(getIt()));
// }

// //* Data Sources
// void _setUpDataSources() {
//   getIt.registerLazySingleton<Preference>(() => Preference());
// }

// //* Repositories
// void _setUpRepositories() {
//   getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryIml());
// }

// //* Cores
// void _setupCores() {
//   getIt.registerLazySingleton<RouteNames>(() => RouteNames());
// }

GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {
  sl.registerSingleton(SignUpBloc(AuthRepositoryIml()));
  sl.registerSingleton(LoginBloc(AuthRepositoryIml()));
  sl.registerSingleton(VerifyBloc(AuthRepositoryIml()));
  sl.registerSingleton(ForgotPasswordBloc(AuthRepositoryIml()));
  sl.registerSingleton(ResetPasswordBloc(AuthRepositoryIml()));
}
