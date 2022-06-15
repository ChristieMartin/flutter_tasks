import 'package:auth_app/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
  }

  bool authenticateUser(final String username, final String password) {
    final bool success = _users.values.any((element) =>
        element.username == username && element.password == password);
    return success;
  }

  Future<Result> createUser(
      final String username, final String password) async {
    final exists = _users.values.any((element) =>
        element.username.toLowerCase().trim() == username.toLowerCase().trim());
    if (exists) {
      return Result.exists;
    }

    try {
      _users.add(User(username, password));
      return Result.success;
    } catch (e) {
      return Result.failure;
    }
  }

  Future<Result> changeUsername(
      final String newUsername, final String oldUsername) async {
    final exists = _users.values.any((element) =>
        element.username.toLowerCase().trim() ==
        newUsername.toLowerCase().trim());
    if (exists) {
      return Result.exists;
    }
    final User userToEdit =
        _users.values.firstWhere((element) => element.username == oldUsername);
    final int index = userToEdit.key as int;
    try {
      await _users.put(index, User(newUsername, userToEdit.password));
      return Result.success;
    } catch (e) {
      return Result.failure;
    }
  }

  Future<void> changePassword(
      final String username, final String newPassword) async {
    final User userToEdit =
        _users.values.firstWhere((element) => element.username == username);
    final int index = userToEdit.key as int;
    await _users.put(index, User(username, newPassword));
  }
}

enum Result { success, failure, exists }
