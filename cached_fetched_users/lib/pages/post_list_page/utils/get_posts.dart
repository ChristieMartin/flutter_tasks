import 'dart:convert';

import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/service/api_service.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Post>> getPosts(int userId, {int? limit}) async {
  final prefs = await SharedPreferences.getInstance();
  final String key = "${AppStrings.postsString}_${userId.toString()}_${limit?.toString() ?? ""}";
  List<Map<String, dynamic>> postsRaw = List<Map<String, dynamic>>.from(
    json.decode(prefs.getString(
            key,) ??
        "[]",) as Iterable<dynamic>,
  );
  if (postsRaw.isEmpty) {
    postsRaw = List<Map<String, dynamic>>.from(
      await ApiService.sendGet(
        "/posts",
        queryParameters: {"userId": userId, if (limit != null) "_limit": limit},
      ) as Iterable<dynamic>,
    );
    prefs.setString(key, json.encode(postsRaw));
  }

  final List<Post> posts = postsRaw.map(Post.fromJson).toList();

  return posts;
}
