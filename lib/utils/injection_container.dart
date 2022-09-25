import 'package:auth_app/bloc/login/login_bloc.dart';
import 'package:auth_app/bloc/register/register_bloc.dart';
import 'package:auth_app/core/pref.dart';
import 'package:auth_app/core/router_name.dart';
import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:get_it/get_it.dart';

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
  sl.registerSingleton(RegisterBloc(AuthRepositoryIml()));
  sl.registerSingleton(LoginBloc(AuthRepositoryIml()));
}
