import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositoriy/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

  final AuthRepository repository;
  ForgotPasswordBloc(this.repository) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEventSubmit>(_onForgotPassword);
  }

  void _onForgotPassword(ForgotPasswordEventSubmit event,
      Emitter<ForgotPasswordState> emit) async {
    if (!forgotFormKey.currentState!.validate()) return;
    if (event.email.isEmpty) {
      emit(const ForgotPasswordFailed(errorMsg: "Email can't be empty"));
      return;
    }
    emit(ForgotPasswordLoading());
    try {
      await repository.forgotPassword(event.email);
      emit(ForgotPasswordLoaded(
        email: event.email,
      ));
    } catch (e) {
      emit(ForgotPasswordFailed(errorMsg: e.toString()));
    }
  }
}
