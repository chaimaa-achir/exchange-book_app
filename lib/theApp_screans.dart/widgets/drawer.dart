import 'package:flutter/material.dart';
import 'package:mini_project/Authentication_sreans.dart/login.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'package:mini_project/theApp_screans.dart/screans/change-pass.dart';
import 'package:mini_project/theApp_screans.dart/screans/profilecurrentuser.dart';

class CustomDrawer extends StatelessWidget {
  
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // فقط هذا الجزء فيه التدرج
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
                  color: Colors.transparent, // لازم عشان ما يغطي التدرج
                ),
                accountName: Text(
                  "Ali Hassan",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  "ali@yahoo.com",
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPictureSize: Size.square(80),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/img/history.jpg"),
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Your Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  ProfileCurrentUserScreen()),
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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginscrean()),
              );
            },
          ),
        ],
      ),
    );
  }
}
