part of 'user_preview_bloc.dart';


abstract class UserPreviewEvent {}

class LoadUserPreview extends UserPreviewEvent{
  final int userId;

  LoadUserPreview(this.userId);
}
