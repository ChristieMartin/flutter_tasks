part of 'user_preview_bloc.dart';


abstract class UserPreviewState {}

class UserPreviewLoading extends UserPreviewState {}

class UserPreviewPostsAndAlbumsLoaded extends UserPreviewState {
  final List<Post> posts;
  final List<Album> albums;
  final List<Photo> albumPreviews;

  UserPreviewPostsAndAlbumsLoaded(this.posts, this.albums, this.albumPreviews);
}

class UserPreviewLoadingFailed extends UserPreviewState {
  final String error;

  UserPreviewLoadingFailed(this.error);
}
