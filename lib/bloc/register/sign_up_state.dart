// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const SignUpLoaded({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class SignUpValid extends SignUpState {
  
}
class SignUpFailed extends SignUpState {
  final String errorMsg;
  const SignUpFailed({
    required this.errorMsg,
  });
}
