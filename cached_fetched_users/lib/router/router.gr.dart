// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../pages/album_list_page/widgets/album_list_page.dart' as _i4;
import '../pages/detailed_album_page/models/album.dart' as _i11;
import '../pages/detailed_album_page/widgets/detailed_album_page.dart' as _i6;
import '../pages/detailed_post_page/models/post.dart' as _i10;
import '../pages/detailed_post_page/widgets/detailed_post_page.dart' as _i5;
import '../pages/home_page/widgets/home_page.dart' as _i1;
import '../pages/post_list_page/widgets/post_list_page.dart' as _i3;
import '../pages/user_page/models/user.dart' as _i9;
import '../pages/user_page/widgets/user_page.dart' as _i2;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<Object>(
          routeData: routeData, child: const _i1.HomePage());
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return _i7.MaterialPageX<Object>(
          routeData: routeData,
          child: _i2.UserPage(key: args.key, user: args.user));
    },
    PostListRoute.name: (routeData) {
      final args = routeData.argsAs<PostListRouteArgs>();
      return _i7.MaterialPageX<Object>(
          routeData: routeData,
          child: _i3.PostListPage(key: args.key, user: args.user));
    },
    AlbumListRoute.name: (routeData) {
      final args = routeData.argsAs<AlbumListRouteArgs>();
      return _i7.MaterialPageX<Object>(
          routeData: routeData,
          child: _i4.AlbumListPage(key: args.key, user: args.user));
    },
    DetailedPostRoute.name: (routeData) {
      final args = routeData.argsAs<DetailedPostRouteArgs>();
      return _i7.MaterialPageX<Object>(
          routeData: routeData,
          child: _i5.DetailedPostPage(key: args.key, post: args.post));
    },
    DetailedAlbumRoute.name: (routeData) {
      final args = routeData.argsAs<DetailedAlbumRouteArgs>();
      return _i7.MaterialPageX<Object>(
          routeData: routeData,
          child: _i6.DetailedAlbumPage(key: args.key, album: args.album));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(HomeRoute.name, path: '/'),
        _i7.RouteConfig(UserRoute.name, path: '/user-page'),
        _i7.RouteConfig(PostListRoute.name, path: '/post-list-page'),
        _i7.RouteConfig(AlbumListRoute.name, path: '/album-list-page'),
        _i7.RouteConfig(DetailedPostRoute.name, path: '/detailed-post-page'),
        _i7.RouteConfig(DetailedAlbumRoute.name, path: '/detailed-album-page')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.UserPage]
class UserRoute extends _i7.PageRouteInfo<UserRouteArgs> {
  UserRoute({_i8.Key? key, required _i9.User user})
      : super(UserRoute.name,
            path: '/user-page', args: UserRouteArgs(key: key, user: user));

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.user});

  final _i8.Key? key;

  final _i9.User user;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i3.PostListPage]
class PostListRoute extends _i7.PageRouteInfo<PostListRouteArgs> {
  PostListRoute({_i8.Key? key, required _i9.User user})
      : super(PostListRoute.name,
            path: '/post-list-page',
            args: PostListRouteArgs(key: key, user: user));

  static const String name = 'PostListRoute';
}

class PostListRouteArgs {
  const PostListRouteArgs({this.key, required this.user});

  final _i8.Key? key;

  final _i9.User user;

  @override
  String toString() {
    return 'PostListRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.AlbumListPage]
class AlbumListRoute extends _i7.PageRouteInfo<AlbumListRouteArgs> {
  AlbumListRoute({_i8.Key? key, required _i9.User user})
      : super(AlbumListRoute.name,
            path: '/album-list-page',
            args: AlbumListRouteArgs(key: key, user: user));

  static const String name = 'AlbumListRoute';
}

class AlbumListRouteArgs {
  const AlbumListRouteArgs({this.key, required this.user});

  final _i8.Key? key;

  final _i9.User user;

  @override
  String toString() {
    return 'AlbumListRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i5.DetailedPostPage]
class DetailedPostRoute extends _i7.PageRouteInfo<DetailedPostRouteArgs> {
  DetailedPostRoute({_i8.Key? key, required _i10.Post post})
      : super(DetailedPostRoute.name,
            path: '/detailed-post-page',
            args: DetailedPostRouteArgs(key: key, post: post));

  static const String name = 'DetailedPostRoute';
}

class DetailedPostRouteArgs {
  const DetailedPostRouteArgs({this.key, required this.post});

  final _i8.Key? key;

  final _i10.Post post;

  @override
  String toString() {
    return 'DetailedPostRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i6.DetailedAlbumPage]
class DetailedAlbumRoute extends _i7.PageRouteInfo<DetailedAlbumRouteArgs> {
  DetailedAlbumRoute({_i8.Key? key, required _i11.Album album})
      : super(DetailedAlbumRoute.name,
            path: '/detailed-album-page',
            args: DetailedAlbumRouteArgs(key: key, album: album));

  static const String name = 'DetailedAlbumRoute';
}

class DetailedAlbumRouteArgs {
  const DetailedAlbumRouteArgs({this.key, required this.album});

  final _i8.Key? key;

  final _i11.Album album;

  @override
  String toString() {
    return 'DetailedAlbumRouteArgs{key: $key, album: $album}';
  }
}
