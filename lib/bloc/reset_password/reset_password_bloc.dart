// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:auth_app/repositoriy/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository repository;
  ResetPasswordBloc(
    this.repository,
  ) : super(ResetPasswordInitial()) {
    on<ResetUserPasswordEvent>(resetPassword);
  }

  void resetPassword(
      ResetUserPasswordEvent event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoading());

    try {
      await repository.resetPassword(event.Code, event.Email, event.Password);
      emit(ResetPasswordLoaded(
          Code: event.Code, Email: event.Email, Password: event.Password));
    } catch (e) {
      emit(ResetPasswordFailed(errorMsg: e.toString()));
    }
  }
}
