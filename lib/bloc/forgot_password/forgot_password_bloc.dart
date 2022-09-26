import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final formKey = GlobalKey<FormState>();

  final AuthRepository repository;
  ForgotPasswordBloc(this.repository) : super(ForgotPasswordInitial()) {
    on<ForgotUserPasswordEvent>(forgotPassword);
  }

  void forgotPassword(
      ForgotUserPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    if (!formKey.currentState!.validate()) return;
    emit(ForgotPasswordLoading());
    try {
      await repository.forgotPassword(event.Email);
      emit(ForgotPasswordLoaded(
        Email: event.Email,
      ));
    } catch (e) {
      emit(ForgotPasswordFailed(errorMsg: e.toString()));
    }
  }
}
