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
  final String Code;
  final String Email;
  final String Password;
  const ResetPasswordLoaded({
    required this.Code,
    required this.Email,
    required this.Password,
  });
}

class ResetPasswordFailed extends ResetPasswordState {
  final String errorMsg;
  const ResetPasswordFailed({
    required this.errorMsg,
  });
}
