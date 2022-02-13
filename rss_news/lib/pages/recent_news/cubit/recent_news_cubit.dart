import 'package:bloc/bloc.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:meta/meta.dart';
import 'package:rss_news/service/rss_api.dart';

part 'recent_news_state.dart';

class RecentNewsCubit extends Cubit<RecentNewsState> {
  final RssApi _feed;
  RecentNewsCubit(this._feed) : super(RecentNewsInitial());

  Future<void> loadNews() async {
    try {
      emit(RecentNewsLoaded(await _feed.fetchNews()));
    } catch (e) {
      emit(RecentNewsError(e.toString().substring(11)));
    }
  }

  Future<void> reloadNews() async {
    emit(RecentNewsInitial());
  }
}
