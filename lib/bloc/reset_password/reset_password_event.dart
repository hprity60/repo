// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetUserPasswordEvent extends ResetPasswordEvent {
  
  final String Code;
  final String Email;
  final String Password;

  const ResetUserPasswordEvent(this.Code, this.Email, this.Password);
  
 
}
