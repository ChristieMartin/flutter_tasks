import 'package:cached_fetched_users/pages/user_page/models/address.dart';
import 'package:cached_fetched_users/pages/user_page/models/company.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
      required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company,
  });

  User.fromJson(Map<String, dynamic> json)
    : id = json["id"] as int,
      name = json["name"] as String,
      username = json["username"] as String,
      email = json["email"] as String,
      address = Address.fromJson(json["address"] as Map<String, dynamic>),
      phone = json["phone"] as String,
      website = json["website"] as String,
      company = Company.fromJson(json["company"] as Map<String, dynamic>);
  
}
