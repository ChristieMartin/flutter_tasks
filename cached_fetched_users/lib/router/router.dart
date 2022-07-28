import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/album_list_page/widgets/album_list_page.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/widgets/detailed_album_page.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/widgets/detailed_post_page.dart';
import 'package:cached_fetched_users/pages/home_page/widgets/home_page.dart';
import 'package:cached_fetched_users/pages/post_list_page/widgets/post_list_page.dart';
import 'package:cached_fetched_users/pages/user_page/widgets/user_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<Object>(
      page: HomePage,
      initial: true,
    ),
    AutoRoute<Object>(
      page: UserPage,
    ),
    AutoRoute<Object>(
      page: PostListPage,
    ),
    AutoRoute<Object>(
      page: AlbumListPage,
    ),
    AutoRoute<Object>(
      page: DetailedPostPage,
    ),
    AutoRoute<Object>(
      page: DetailedAlbumPage,
    ),
  ],
)

class $AppRouter {}
