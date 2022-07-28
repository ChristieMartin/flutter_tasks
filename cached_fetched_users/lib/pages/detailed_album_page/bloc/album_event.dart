part of 'album_bloc.dart';


abstract class AlbumEvent {}

class LoadAlbum extends AlbumEvent {
  final Album album;

  LoadAlbum(this.album);
}
