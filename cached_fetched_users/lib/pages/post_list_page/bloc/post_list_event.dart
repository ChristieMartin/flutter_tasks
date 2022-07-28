part of 'post_list_bloc.dart';


abstract class PostListEvent {}

class LoadPosts extends PostListEvent {
  final int userId;

  LoadPosts(this.userId);

}
