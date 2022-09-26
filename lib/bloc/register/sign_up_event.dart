// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventSubmit extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const SignUpEventSubmit({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class SignUpEventFirstNameChanged extends SignUpEvent {
  final String firstName;
 const SignUpEventFirstNameChanged({
    required this.firstName,
  });
  
}
class SignUpEventLastNameChanged extends SignUpEvent {
  final String lastName;
  const SignUpEventLastNameChanged({
    required this.lastName,
  });
   
}

class SignUpEventEmailChanged extends SignUpEvent {
  final String email;
  const SignUpEventEmailChanged({
    required this.email,
  });
}

class SignUpEventPasswordChanged extends SignUpEvent {
  final String password;
  const SignUpEventPasswordChanged({
    required this.password,
  });
}
