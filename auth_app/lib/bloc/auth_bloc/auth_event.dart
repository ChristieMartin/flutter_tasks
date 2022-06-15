part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent({
    required this.username,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  RegisterEvent({
    required this.username,
    required this.password,
  });
}

class InitServiceEvent extends AuthEvent {}

class ChangePassword extends AuthEvent {
  final String newPassword;
  ChangePassword(this.newPassword);
}

class ChangeUsername extends AuthEvent {
  final String newUsername;
  ChangeUsername(this.newUsername);
}

class Logout extends AuthEvent {}
