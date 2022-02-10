import 'dart:convert';


import 'package:weather_bloc/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _api = "402988222081e66306736ff68d1bc1f5";
  static const String _baseUrl = "http://api.openweathermap.org/data/2.5";

  static Future<Weather> fetchCurrentWeather(
      {String query = "", String latitude = "", String longitude = ""}) async {
    final String url =
        '$_baseUrl/weather?q=$query&lat=$latitude&lon=$longitude&appid=$_api&units=metric';
    final uri = Uri.parse(url);
    final http.Response response = await http.post(uri);
    if (response.statusCode == 200) {
      return Weather.fromJSON(json.decode(response.body));
    }
    if (response.statusCode == 404) {
      throw Exception("Try another city");
    } else {
      throw Exception(
          "Failed to fetch current weather.\nError code: ${response.statusCode}");
    }
  }

  static Future<List<Weather>> fetchHourlyWeather(
      {String query = "", String latitude = "", String longitude = ""}) async {
    final String url =
        '$_baseUrl/forecast?q=$query&lat=$latitude&lon=$longitude&appid=$_api&units=metric';
    final uri = Uri.parse(url);
    final http.Response response = await http.post(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<Weather> data = (jsonData["list"] as List<dynamic>)
          .map((i) => Weather.fromJSON(i))
          .toList();
      return data;
    } else {
      throw Exception("Failed to fetch hourly weather.\nError code: ${response.statusCode}");
    }
  }
}
