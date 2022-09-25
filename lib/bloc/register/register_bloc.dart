import 'package:auth_app/model/register_model.dart';
import 'package:auth_app/repositoriy/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository repository;
  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<RegisterUserEvent>(register);
  }

  void register(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await repository.register(
        event.Email, event.Password, event.FirstName, event.LastName);
    emit(RegisterLoaded(Email: event.Email, Password: event.Password, FirstName: event.FirstName, LastName: event.LastName));

    emit(RegisterFailed(state.toString()));
  }
}
