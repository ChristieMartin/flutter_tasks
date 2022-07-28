import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/album_list_page/utils/get_albums.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/utils/get_photos.dart';
import 'package:cached_fetched_users/service/api_service.dart';

part 'album_list_event.dart';
part 'album_list_state.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  AlbumListBloc() : super(AlbumListLoading()) {
    on<LoadAlbumList>(_onLoadAlbumList);
  }

  Future<void> _onLoadAlbumList(LoadAlbumList event, Emitter emit) async {
    emit(AlbumListLoading());
    try {
      final List<Album> albums = await getAlbums(event.userId);

      emit(AlbumListLoaded(albums, null));

      final List<Photo> albumPreviews = <Photo>[];
      for (final Album album in albums) {
        final Photo photo = await getPhoto(album.id);
        albumPreviews.add(photo);
      }
      emit(AlbumListLoaded(albums, albumPreviews));
    } catch (e) {
      emit(AlbumListLoadingFailed(e.toString()));
      rethrow;
    }
  }
}
