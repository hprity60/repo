// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordLoaded extends ResetPasswordState {
  final String code;
  final String email;
  final String password;
  const ResetPasswordLoaded({
    required this.code,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [code, email, password];
}

class ResetPasswordFailed extends ResetPasswordState {
  final String errorMsg;
  const ResetPasswordFailed({
    required this.errorMsg,
  });
  @override
  List<Object> get props => [errorMsg];
}
