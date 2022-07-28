part of 'album_list_bloc.dart';

abstract class AlbumListEvent {}

class LoadAlbumList extends AlbumListEvent {
  final int userId;

  LoadAlbumList(this.userId);

}
