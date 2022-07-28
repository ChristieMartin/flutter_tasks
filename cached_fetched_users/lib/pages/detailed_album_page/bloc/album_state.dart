part of 'album_bloc.dart';


abstract class AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoadingFailed extends AlbumState {
  final String error;

  AlbumLoadingFailed(this.error);
}

class AlbumLoaded extends AlbumState {
  final List<Photo> albumPhoto;

  AlbumLoaded(this.albumPhoto);
}
