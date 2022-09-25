// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  
  final String Email;
  final String Password;
  final String FirstName;
  final String LastName;
 const RegisterUserEvent({
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.Password,
  });
}
