// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final String username;
  final String Password;
  const LoginLoaded({
    required this.username,
    required this.Password,
  });
}

class LoginFailed extends LoginState {
  final String errorMsg;
 const LoginFailed({
    required this.errorMsg,
  });
}
