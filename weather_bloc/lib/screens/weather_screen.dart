import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:weather_bloc/screens/widgets/weather_widgets.dart';
import 'package:weather_bloc/models/weather.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;
  const WeatherScreen({
    Key? key,
    required this.weather,
    required this.hourlyWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            weather.cityName,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white, fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            "Today's Weather",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 16.sp, fontWeight: FontWeight.bold)
          ),
        ),
        HourlyWeather(hourlyWeather: hourlyWeather),
        Center(
          child: SizedBox(
            width: 50.w,
            child: WeatherCard(
              title: DateTime.now().toString().substring(11, 16),
              temperature: weather.temperature,
              description: weather.description,
              icon: weather.icon,
              titleSize: 26.sp,
              temperatureFontSize: 33.sp,
              iconScale: 1,
            ),
          ),
        ),
        AdditionalDetails(wind: weather.wind, humidity: weather.humidity, feelsLike: weather.feelsLike)
      ],
    );
  }
}
