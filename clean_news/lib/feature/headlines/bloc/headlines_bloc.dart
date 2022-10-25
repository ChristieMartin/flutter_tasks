import 'package:bloc/bloc.dart';
import 'package:clean_news/feature/home/model/article.dart';
import 'package:clean_news/service/api_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'headlines_event.dart';
part 'headlines_state.dart';
part 'headlines_bloc.freezed.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  HeadlinesBloc() : super(const _Loading()) {
    on<_FetchHeadlines>(_onFetchHeadlines);
  }

  void _onFetchHeadlines(_FetchHeadlines event, emit) async {
    emit(const HeadlinesState.loading());
    try {
      final response = Map<String, dynamic>.from(await ApiService.sendGet(
        'top-headlines',
        queryParameters: {
          'category': 'Apple',
        },
      ));

      if (response['status'] == 'error') {
        
        emit(HeadlinesState.error(response['message']));
        return;
      }
      List<Map<String, dynamic>> res = List<Map<String, dynamic>>.from(response['articles']);
      List<Article> articles = List<Article>.from(res.map(Article.fromJson).toList());
      emit(HeadlinesState.headlinesFetched(articles));
    } catch (e) {
      emit(HeadlinesState.error(e.toString()));
    }
  }
}
