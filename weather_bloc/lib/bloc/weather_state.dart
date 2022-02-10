part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherSearch extends WeatherState {
  final String error;
  const WeatherSearch({this.error = ""});
}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Weather> hourlyWeather;

  const WeatherLoaded({required this.weather, required this.hourlyWeather});
}
