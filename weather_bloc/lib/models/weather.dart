class Weather {
  final String cityName;
  final String temperature;
  final String icon;
  final String description;
  final DateTime? time;
  final String wind;
  final String humidity;
  final String feelsLike;

  Weather(
      {this.cityName = "",
      this.temperature = "",
      this.icon = "",
      this.description = "",
      this.time,
      this.wind = "",
      this.humidity = "",
      this.feelsLike = "",
      });

  factory Weather.fromJSON(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"] ?? "",
      temperature: json['main']['temp'].round().toString(),
      icon: json["weather"][0]['icon'] ?? "",
      description: json["weather"][0]['main'] ?? "",
      time: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
      wind: json["wind"]["speed"].round().toString(),
      humidity: json["main"]["humidity"].toString(),
      feelsLike: json["main"]["feels_like"].round().toString(),
    );
  }
}
