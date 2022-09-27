// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

import '../../../../data/repositoriy/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: 'loginFormKey');
  final AuthRepository repository;
  LoginBloc(
    this.repository,
  ) : super(LoginInitial()) {
    on<LoginEventSubmit>(_onLogin);
  }

  void _onLogin(LoginEventSubmit event, Emitter<LoginState> emit) async {
    if (!loginFormKey.currentState!.validate()) return;
    if (event.username.isEmpty || Utils.isEmail(event.username)) {
      emit(const LoginFailed(errorMsg: "Email required!"));
      return;
    }
    if (Utils.isPhoneNumber(event.password)) {
      emit(const LoginFailed(errorMsg: "Enter Atleast 8 charecter Password."));
      return;
    }
    emit(LoginLoading());
    try {
      await repository.login(
        event.username,
        event.password,
      );
      emit(LoginLoaded(username: event.username, password: event.password));
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
    }
  }
}
