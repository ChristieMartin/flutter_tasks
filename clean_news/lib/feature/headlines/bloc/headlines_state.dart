part of 'headlines_bloc.dart';

@freezed
class HeadlinesState with _$HeadlinesState {
  const factory HeadlinesState.loading() = _Loading;
  const factory HeadlinesState.error(String error) = _Error;
  const factory HeadlinesState.headlinesFetched(List<Article> articles) = _HeadlinesFetched;

}
