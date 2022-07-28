class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  Address.fromJson(Map<String, dynamic> json)
    : street = json["street"] as String,
      suite = json["suite"] as String,
      city = json["city"] as String,
      zipcode = json["zipcode"] as String,
      geo = Geo.fromJson(json["geo"] as Map<String, dynamic>);
}

class Geo {
  final double lat;
  final double lon;

  const Geo({required this.lat, required this.lon});

  Geo.fromJson(Map<String, dynamic> json)
    : lat = double.parse((json["lat"] ?? "0") as String),
      lon = double.parse((json["lon"] ?? "0") as String);
}
