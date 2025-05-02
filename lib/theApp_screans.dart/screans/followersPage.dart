// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
class FollowersScreen extends StatefulWidget {
  final bool isFollowers; 

  const FollowersScreen({super.key, required this.isFollowers});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  late Future<List<Map<String, dynamic>>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = fetchUsers();
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  final url = widget.isFollowers
      ? 'https://books-paradise.onrender.com/follow/followers'
      : 'https://books-paradise.onrender.com/follow/followings';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    List<dynamic> result = [];

    if (widget.isFollowers) {
      
      result = data['followers'] ?? [];
    } else {
    
      result = data['result'] ?? [];
    }

    return result.map((e) => e as Map<String, dynamic>).toList();
  } else {
    throw Exception('Followers loading failed: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFollowers ? 'Followers' : 'Following'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('There are no users.'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['profile_pic'] ?? ''),
                  ),
                  title: Text(user['username'] ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
