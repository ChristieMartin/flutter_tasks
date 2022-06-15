part of 'auth_bloc.dart';


abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  final String? error;
  AuthInitial({this.error});
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends AuthState {
  final User user;
  final String? error;
  LoginSuccess(this.user, {this.error});

  @override
  List<Object?> get props => [user];
}

class InitServiceState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}