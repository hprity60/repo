// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verify_bloc.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifyLoaded extends VerifyState {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  const VerifyLoaded({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  @override
  List<Object> get props => [email, password, firstName, lastName];
}

class VerifyFailed extends VerifyState {
  final String errorMsg;
  const VerifyFailed({
    required this.errorMsg,
  });
  @override
  List<Object> get props => [errorMsg];
}
