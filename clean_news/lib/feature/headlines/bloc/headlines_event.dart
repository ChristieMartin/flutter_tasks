part of 'headlines_bloc.dart';

@freezed
class HeadlinesEvent with _$HeadlinesEvent {
  const factory HeadlinesEvent.fetchHeadlines() = _FetchHeadlines;
}