part of 'album_list_bloc.dart';


abstract class AlbumListState {}

class AlbumListLoading extends AlbumListState {}

class AlbumListLoadingFailed extends AlbumListState {
  final String error;

  AlbumListLoadingFailed(this.error);
}

class AlbumListLoaded extends AlbumListState {
  final List<Album> albums;
  final List<Photo>? albumPreviews;

  AlbumListLoaded(this.albums, this.albumPreviews);
}
