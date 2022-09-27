// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetUserPasswordEvent extends ResetPasswordEvent {
  final String code;
  final String email;
  final String password;
  const ResetUserPasswordEvent({
    required this.code,
    required this.email,
    required this.password,
  });
    @override
  List<Object> get props => [code, email, password];
}