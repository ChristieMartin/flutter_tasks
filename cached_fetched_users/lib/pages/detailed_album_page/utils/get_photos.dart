import 'dart:convert';

import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/service/api_service.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Photo>> getPhotos(int albumId, {int? limit}) async {
  final prefs = await SharedPreferences.getInstance();
  final String key =
      "${AppStrings.photosString}_${albumId.toString()}_${limit?.toString() ?? ""}";
  List<Map<String, dynamic>> photosRaw = List<Map<String, dynamic>>.from(
    json.decode(
      prefs.getString(
            key,
          ) ??
          "[]",
    ) as Iterable<dynamic>,
  );
  if (photosRaw.isEmpty) {
    photosRaw = List<Map<String, dynamic>>.from(
      await ApiService.sendGet(
        "/photos",
        queryParameters: {
          "albumId": albumId,
          if (limit != null) "_limit": limit
        },
      ) as Iterable<dynamic>,
    );
    prefs.setString(key, json.encode(photosRaw));
  }

  final List<Photo> photos = photosRaw.map(Photo.fromJson).toList();

  return photos;
}

Future<Photo> getPhoto(int albumId) async {
  final prefs = await SharedPreferences.getInstance();
  final String key =
      "${AppStrings.photosString}_${albumId.toString()}_1}";
  Map<String, dynamic>? photoRaw = prefs.containsKey(key)
      ? Map<String, dynamic>.from(json.decode(
          prefs.getString(
            key,
          )!,
        ) as Map<String, dynamic>,)
      : null;

  if (photoRaw == null) {
    photoRaw = List<Map<String, dynamic>>.from(
      await ApiService.sendGet(
        "/photos",
        queryParameters: {"albumId": albumId, "_limit": 1},
      ) as Iterable<dynamic>,
    ).first;
    prefs.setString(key, json.encode(photoRaw));
  }

  final Photo photo = Photo.fromJson(photoRaw);

  return photo;
}
