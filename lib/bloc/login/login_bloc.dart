// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_app/model/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:auth_app/repositoriy/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  LoginBloc(
    this.repository,
  ) : super(LoginInitial()) {
    on<LoginUserEvent>(login);
  }

  void login(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await repository.login(event.username, event.password);
    emit(LoginLoaded(username: event.username, Password: event.password));
    emit(LoginFailed());
  }
}
