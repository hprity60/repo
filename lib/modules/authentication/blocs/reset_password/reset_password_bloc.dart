// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositoriy/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository repository;
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  ResetPasswordBloc(
    this.repository,
  ) : super(ResetPasswordInitial()) {
    on<ResetUserPasswordEvent>(_onResetPassword);
  }

  void _onResetPassword(
      ResetUserPasswordEvent event, Emitter<ResetPasswordState> emit) async {
    if (!resetFormKey.currentState!.validate()) return;

    if (event.code.isEmpty) {
      emit(const ResetPasswordFailed(
          errorMsg: "Verification Code can't be empty"));
      return;
    }
    if (event.email.isEmpty) {
      emit(const ResetPasswordFailed(errorMsg: "Email can't be empty"));
      return;
    }
    if (event.password.isEmpty) {
      emit(const ResetPasswordFailed(errorMsg: "Password can't be empty"));
      return;
    }
    emit(ResetPasswordLoading());

    try {
      await repository.resetPassword(event.code, event.email, event.password);
      emit(ResetPasswordLoaded(
          code: event.code, email: event.email, password: event.password));
    } catch (e) {
      emit(ResetPasswordFailed(errorMsg: e.toString()));
    }
  }
}
