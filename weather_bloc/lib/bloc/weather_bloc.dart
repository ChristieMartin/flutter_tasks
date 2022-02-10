import 'package:bloc/bloc.dart';
import 'package:weather_bloc/models/weather.dart';
import 'package:weather_bloc/service/weather_service.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherSearch()) {
    on<WeatherSearchInit>((event, emit) => emit(const WeatherSearch()));
    on<WeatherRequest>(_onWeatherRequested);
    on<WeatherCurrentPositionRequest>(_onWeatherCurrentPositionRequest);
  }

  void _onWeatherRequested(event, emit) async {
    emit(WeatherLoading());
    try {
      final Weather weather = await WeatherService.fetchCurrentWeather(
          query: event.cityName,
          longitude: event.longitude,
          latitude: event.latitude);
      final List<Weather> hourlyWeather =
          await WeatherService.fetchHourlyWeather(
              query: event.cityName,
              longitude: event.longitude,
              latitude: event.latitude);
      emit(WeatherLoaded(weather: weather, hourlyWeather: hourlyWeather));
    } catch (e) {
      emit(WeatherSearch(error: e.toString().substring(11)));
    }
  }

  void _onWeatherCurrentPositionRequest(event, emit) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const WeatherSearch(error: "Location services are disabled"));
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const WeatherSearch(
            error: "Location permissions are denied"));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(const WeatherSearch(
          error:
              "Location permissions are permanently denied, we cannot request permissions."));
    }
    Position? position = await Geolocator.getLastKnownPosition();
    position ??= await Geolocator.getCurrentPosition();
    add(WeatherRequest(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString()));
  }
}
