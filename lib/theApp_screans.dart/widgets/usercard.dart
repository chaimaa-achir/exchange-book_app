import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/user.dart';



class Usercard extends StatelessWidget {
  final User user;
  final VoidCallback ontapUser;
  const Usercard({Key? key, required this.user, required this.ontapUser}) : super(key: key);
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontapUser,
        child: Container(
          height: screenHeight * 0.08,
          width: screenWidth * 0.53,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 196, 195, 195),
                  offset: Offset(5, 7),
                  blurRadius: 10,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(user.userimag),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Text(
                  user.username,
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                Text(
                  "200 followers",style: TextStyle(fontSize: 9),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
