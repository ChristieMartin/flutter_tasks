import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/utils/get_photos.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumLoading()) {
    on<LoadAlbum>(_onLoadAlbum);
  }

  Future<void> _onLoadAlbum(LoadAlbum event, Emitter emit) async {
    emit(AlbumLoading());
    try {
      emit(AlbumLoaded(await getPhotos(event.album.id)));
    } catch (e) {
      emit(AlbumLoadingFailed(e.toString()));
      rethrow;
    }
  }
}
