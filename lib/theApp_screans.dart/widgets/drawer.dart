import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/login.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'package:mini_project/theApp_screans.dart/screans/change-pass.dart';
import 'package:mini_project/theApp_screans.dart/screans/profilecurrentuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<Map<String, dynamic>> fetchProfile() async {
  String token = await getToken();
  final url = Uri.parse('https://books-paradise.onrender.com/profile/user-profile');
  
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'profile_pic': data['profile_pic'],
      };
    } else {
      print('Failed to load profile, code: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Connection error: $e');
    return {};
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String username = "";
  String email = "";
  String? userImage;
  late Map<String, dynamic> userMap;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user'); 

    if (userJson != null) {
      userMap = jsonDecode(userJson);
      
      Map<String, dynamic> profileData = await fetchProfile();
      
      setState(() {
        username = userMap['username'] ?? "Guest User";
        email = userMap['email'] ?? "No Email";
        userImage = profileData['profile_pic'] ?? userMap['profile_picture'];
        isLoading = false;
      });
    } else {
      setState(() {
        username = "Guest User";
        email = "No Email";
        userImage = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Drawer(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                accountName: Text(
                  username,
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  email,
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: (userImage != null && userImage!.isNotEmpty)
                      ? NetworkImage(userImage!)
                      : AssetImage("assets/img/user.png") as ImageProvider,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileCurrentUserScreen(
                          user: userMap,
                        )),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Navigationbar(initialIndex: 0)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text("Saves"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Navigationbar(initialIndex: 1)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text("Community"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Navigationbar(initialIndex: 3)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Message"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Navigationbar(initialIndex: 4)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async {
              await logout();

              if (!mounted) return;
              
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loginscrean()),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}