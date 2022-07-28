import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/comment.dart';
import 'package:cached_fetched_users/service/api_service.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsLoading()) {
    on<LoadComments>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  Future<void> _onLoadComments(LoadComments event, Emitter emit) async {
    emit(CommentsLoading());
    try {
      final List<Map<String, dynamic>> commentsRaw =
          List<Map<String, dynamic>>.from(
        await ApiService.sendGet(
          "/comments",
          queryParameters: {"postId": event.postId},
        ) as Iterable<dynamic>,
      );
      final List<Comment> comments = commentsRaw.map(Comment.fromJson).toList();
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsLoadingFailed(e.toString()));
      rethrow;
    }
  }

  Future<void> _onAddComment(AddComment event, Emitter emit) async {
    final CommentsState state = this.state;
    if (state is CommentsLoaded) {
      emit(CommentsLoading());
      try {
        final Map<String, dynamic> rawComment =
            await ApiService.sendPost("/comments", body: event.comment.toJson())
                as Map<String, dynamic>;
        final Comment comment = Comment.fromJson(rawComment);
        emit(CommentsLoaded(state.comments..add(comment)));
      } catch (e) {
        emit(CommentsLoadingFailed(e.toString()));
        rethrow;
      }
    }
  }
}
