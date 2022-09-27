// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verify_bloc.dart';

abstract class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class VerifyEventSubmit extends VerifyEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const VerifyEventSubmit({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  @override
  List<Object> get props => [email, password, firstName, lastName];
}
