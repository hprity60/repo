// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final String Email;

 const ForgotPasswordLoaded({
    required this.Email,
  });
}

class ForgotPasswordFailed extends ForgotPasswordState {
  final String errorMsg;
 const ForgotPasswordFailed({
    required this.errorMsg,
  });
}
