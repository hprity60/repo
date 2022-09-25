// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
    final String Email;
  final String Password;
  final String FirstName;
  final String LastName;
  RegisterLoaded({
    required this.Email,
    required this.Password,
    required this.FirstName,
    required this.LastName,
  });
  
}

class RegisterFailed extends RegisterState {
  final String errorMsg;

 const RegisterFailed(this.errorMsg);
}
