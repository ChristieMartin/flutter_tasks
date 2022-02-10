import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:weather_bloc/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final String temperature;
  final String description;
  final String icon;
  final double titleSize;
  final double temperatureFontSize;
  final double descriptionFontSize;
  final double iconScale;

  const WeatherCard({
    Key? key,
    this.title = "",
    this.temperature = "",
    this.description = "",
    this.icon = "",
    this.titleSize = 16,
    this.temperatureFontSize = 32,
    this.descriptionFontSize = 16,
    this.iconScale = 2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff0F343C),
          borderRadius: BorderRadius.circular(3.h)),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title,
            style: TextStyle(
              fontSize: titleSize,
              color: Colors.white,
            )),
        SizedBox(
          height: titleSize * 2.5,
          width: titleSize * 2.5,
          child: Image.network(
            "http://openweathermap.org/img/wn/$icon@2x.png",
            scale: iconScale,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const CircularProgressIndicator(
                color: Color(0xff3DB3CA),
              );
            },
            errorBuilder: (context, e, _) => const Center(
              child: Icon(Icons.error, color: Color(0xffF05F40)),
            ),
          ),
        ),
        Text(" $temperature°",
            style: TextStyle(
                color: const Color(0xff3DB3CA),
                fontSize: temperatureFontSize,
                fontWeight: FontWeight.bold)),
        Text(description,
            style:
                TextStyle(color: Colors.white, fontSize: descriptionFontSize)),
      ])),
    );
  }
}

class HourlyWeather extends StatelessWidget {
  final List<Weather> hourlyWeather;
  const HourlyWeather({
    Key? key,
    required this.hourlyWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15.h,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyWeather.length,
            itemBuilder: (context, i) {
              Weather weatherItem = hourlyWeather[i];
              return WeatherCard(
                title: "${weatherItem.time!.hour}:00",
                temperature: weatherItem.temperature,
                description: weatherItem.description,
                icon: weatherItem.icon,
                titleSize: 18.sp,
                temperatureFontSize: 18.sp,
                descriptionFontSize: 0,
              );
            }));
  }
}

class AdditionalDetails extends StatelessWidget {
  final String wind;
  final String humidity;
  final String feelsLike;

  const AdditionalDetails({
    Key? key,
    this.wind = "",
    this.humidity = "",
    this.feelsLike = "",
  }) : super(key: key);

  Container _twoTexts(String textOnTop, String textOnBottom) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
      height: 10.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textOnTop, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)), 
          SizedBox(height: 2.h), 
          Text(textOnBottom, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18.sp))
          ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> info = [
      _twoTexts(wind + " km/h", "Wind"),
      _twoTexts(humidity + "%", "Humidity"),
      _twoTexts(" $feelsLike°", "Feels Like"),
    ];
    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: info
        );
  }
}
