import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/album_list_page/utils/get_albums.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/utils/get_photos.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/post_list_page/utils/get_posts.dart';

part 'user_preview_event.dart';
part 'user_preview_state.dart';

class UserPreviewBloc extends Bloc<UserPreviewEvent, UserPreviewState> {
  UserPreviewBloc() : super(UserPreviewLoading()) {
    on<LoadUserPreview>(_onLoadUserPreview);
  }

  Future<void> _onLoadUserPreview(LoadUserPreview event, Emitter emit) async {
    emit(UserPreviewLoading());
    try {

      final List<Album> albums = await getAlbums(event.userId, limit: 3);

      final List<Photo> albumPreviews = [];
      for (final Album album in albums) {
        final Photo photo = await getPhoto(album.id);
        albumPreviews.add(photo);
      }
      emit(UserPreviewPostsAndAlbumsLoaded(
          await getPosts(event.userId, limit: 3), albums, albumPreviews,),);
    } catch (e) {
      emit(UserPreviewLoadingFailed(e.toString()));
      rethrow;
    }
  }
}
