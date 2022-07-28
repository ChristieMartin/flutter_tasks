import 'dart:convert';

import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/service/api_service.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<User>> getUsers() async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> usersRaw = List<Map<String, dynamic>>.from(
    json.decode(prefs.getString(AppStrings.usersString) ?? "[]")
        as Iterable<dynamic>,
  );
  if (usersRaw.isEmpty) {
    usersRaw = List<Map<String, dynamic>>.from(
      await ApiService.sendGet("/users") as Iterable<dynamic>,
    );
    prefs.setString(AppStrings.usersString, json.encode(usersRaw));
  }

  final List<User> users = usersRaw.map(User.fromJson).toList();
  return users;
}
