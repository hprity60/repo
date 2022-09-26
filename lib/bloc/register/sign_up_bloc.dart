import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository repository;
  final formKey = GlobalKey<FormState>();
  SignUpBloc(this.repository) : super(SignUpInitial()) {
    on<SignUpEventSubmit>(register);
    on<SignUpEventFirstNameChanged>(_onFirstNameChanged);
    on<SignUpEventLastNameChanged>(_onLastNameChanged);
    on<SignUpEventEmailChanged>(_onEmailChanged);
    on<SignUpEventPasswordChanged>(_onPasswordChanged);
  }

  void register(SignUpEventSubmit event, Emitter<SignUpState> emit) async {
    if (!formKey.currentState!.validate()) return;
    emit(SignUpLoading());
    try {
      await repository.register(
          event.email, event.password, event.firstName, event.lastName);
      emit(SignUpLoaded(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName));
    } catch (e) {
      emit(SignUpFailed(errorMsg: e.toString()));
    }
  }

  _onLastNameChanged(
      SignUpEventLastNameChanged event, Emitter<SignUpState> emit) async {
    if (event.lastName == '' || event.lastName.isEmpty) {
      emit(const SignUpFailed(errorMsg: 'Please enter Last Name'));
    } else {
      emit(SignUpValid());
    }
  }

  _onFirstNameChanged(
      SignUpEventFirstNameChanged event, Emitter<SignUpState> emit) async {
    if (event.firstName == '' || event.firstName.isEmpty) {
      emit(const SignUpFailed(errorMsg: 'Please enter First Name'));
    } else {
      emit(SignUpValid());
    }
  }

  _onEmailChanged(
      SignUpEventEmailChanged event, Emitter<SignUpState> emit) async {
    if (event.email == '' || Utils.isEmail(event.email.trim())) {
      emit(const SignUpFailed(errorMsg: 'Please enter Valid Email'));
    } else {
      emit(SignUpValid());
    }
  }

  _onPasswordChanged(
      SignUpEventPasswordChanged event, Emitter<SignUpState> emit) async {
    if (event.password.length < 8) {
      emit(const SignUpFailed(errorMsg: 'Atleast 8 character'));
    } else {
      emit(SignUpValid());
    }
  }
}
