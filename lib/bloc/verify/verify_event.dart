part of 'verify_bloc.dart';

abstract class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class VerifyUserEvent extends VerifyEvent {
  
  final String Email;
  final String Password;
  final String FirstName;
  final String LastName;
 const VerifyUserEvent({
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.Password,
  });
}
