part of 'users_bloc.dart';


abstract class UsersState {}

class UsersLoading extends UsersState {}

class UsersLoadingFailed extends UsersState {
  final String error;

  UsersLoadingFailed(this.error);
}

class UsersLoaded extends UsersState {
  final List<User> users;

  UsersLoaded(this.users);
}
