part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherSearchInit extends WeatherEvent {
  const WeatherSearchInit() : super();
}

class WeatherRequest extends WeatherEvent {
  final String? cityName;
  final String? latitude;
  final String? longitude;
  const WeatherRequest({this.cityName = "", this.latitude = "", this.longitude = ""}) : super();
}

class WeatherCurrentPositionRequest extends WeatherEvent {
  const WeatherCurrentPositionRequest() : super();
}