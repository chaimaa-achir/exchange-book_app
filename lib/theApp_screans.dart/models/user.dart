// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int userid;
  final String username;
  final String? userimag;
  final int nbrflowers;

  User({
    required  this.userid,
    required this.userimag,
    required this.username,
    required this.nbrflowers,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userid: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString()) ?? 0
          : 0,
      userimag: json['profile_pic'],
      username: json['username'] ?? '',
      nbrflowers: int.tryParse(json['followers_count']) ?? 0,
    );
  }

  static Future<List<User>> fetchTopUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://books-paradise.onrender.com/home/top-users'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        throw Exception('Failed to load top users');
      }
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }
}
