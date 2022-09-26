// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotUserPasswordEvent extends ForgotPasswordEvent {
  
  final String Email;
 const ForgotUserPasswordEvent({
    required this.Email,
  });
  
}
