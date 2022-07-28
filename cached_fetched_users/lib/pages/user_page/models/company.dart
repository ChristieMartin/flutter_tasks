class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name, 
    required this.catchPhrase, 
    required this.bs,
  });
  
  Company.fromJson(Map<String, dynamic> json)
    : name = json["name"] as String,
      catchPhrase = json["catchPhrase"] as String,
      bs = json["bs"] as String;
  
}
