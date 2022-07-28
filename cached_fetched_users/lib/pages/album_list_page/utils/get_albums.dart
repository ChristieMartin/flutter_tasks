import 'dart:convert';

import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/service/api_service.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Album>> getAlbums(int userId, {int? limit}) async {
  final prefs = await SharedPreferences.getInstance();
  final String key = "${AppStrings.albumsString}_${userId.toString()}_${limit?.toString() ?? ""}";
  List<Map<String, dynamic>> albumsRaw = List<Map<String, dynamic>>.from(
    json.decode(prefs.getString(
            key,) ??
        "[]",) as Iterable<dynamic>,
  );
  if (albumsRaw.isEmpty) {
    albumsRaw = List<Map<String, dynamic>>.from(
      await ApiService.sendGet(
        "/albums",
        queryParameters: {"userId": userId, if (limit != null) "_limit": limit},
      ) as Iterable<dynamic>,
    );
    prefs.setString(key, json.encode(albumsRaw));
  }

  final List<Album> albums = albumsRaw.map(Album.fromJson).toList();

  return albums;
}
