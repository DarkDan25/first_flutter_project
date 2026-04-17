part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class RegisterSubmitted extends LoginEvent {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterSubmitted({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [username, password, firstName, lastName];
}

class LoginLogoutRequested extends LoginEvent {}