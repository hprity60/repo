// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:auth_app/repositoriy/auth_repository.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AuthRepository repository;
  VerifyBloc(
    this.repository,
  ) : super(VerifyInitial()) {
    on<VerifyUserEvent>(verify);
  }

  void verify(VerifyUserEvent event, Emitter<VerifyState> emit) async {
    emit(VerifyLoading());
    try {
      await repository.verifyUser(
          event.Email, event.Password, event.FirstName, event.LastName);
      emit(VerifyLoaded(
          Email: event.Email,
          Password: event.Password,
          FirstName: event.FirstName,
          LastName: event.LastName));
    } catch (e) {
      emit(VerifyFailed(errorMsg: e.toString()));
    }
  }
}
