part of 'comments_bloc.dart';


abstract class CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsLoadingFailed extends CommentsState {
  final String error;

  CommentsLoadingFailed(this.error);

}

class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  CommentsLoaded(this.comments);
}
