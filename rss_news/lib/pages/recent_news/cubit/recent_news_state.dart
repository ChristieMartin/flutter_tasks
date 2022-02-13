part of 'recent_news_cubit.dart';

@immutable
abstract class RecentNewsState {}

class RecentNewsInitial extends RecentNewsState {}

class RecentNewsLoaded extends RecentNewsState {
  final List<RssItem> news;

  RecentNewsLoaded(this.news);
}

class RecentNewsError extends RecentNewsState {
  final String error;
  RecentNewsError(this.error);
}
