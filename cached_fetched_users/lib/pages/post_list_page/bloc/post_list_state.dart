part of 'post_list_bloc.dart';


abstract class PostListState {}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final List<Post> posts;

  PostListLoaded(this.posts);
}

class PostListLoadingFailed extends PostListState {
  final String error;

  PostListLoadingFailed(this.error);

}
