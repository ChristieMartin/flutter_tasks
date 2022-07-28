import 'package:bloc/bloc.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/post_list_page/utils/get_posts.dart';



part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc() : super(PostListLoading()) {
    on<LoadPosts>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter emit) async{
    emit(PostListLoading());
    try {
      emit(PostListLoaded(await getPosts(event.userId)));
    } catch (e) {
      emit(PostListLoadingFailed(e.toString()));
      rethrow;
    }
  }

}
