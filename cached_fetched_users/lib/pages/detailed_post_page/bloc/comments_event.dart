part of 'comments_bloc.dart';

abstract class CommentsEvent {}

class LoadComments extends CommentsEvent {
  final int postId;

  LoadComments(this.postId);
}

class AddComment extends CommentsEvent {
  final Comment comment;

  AddComment(this.comment);
}
