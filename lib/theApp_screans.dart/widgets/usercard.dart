import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/user.dart';

class Usercard extends StatelessWidget {
  final User user;
  final VoidCallback ontapUser;
  const Usercard({super.key, required this.user, required this.ontapUser});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: ontapUser,
        child: Container(
          height: screenHeight * 0.02,
          width: screenWidth * 0.45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
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
                  radius: 20,
                  backgroundImage:
                      user.userimag != null && user.userimag!.isNotEmpty
                          ? NetworkImage(user.userimag!)
                          : AssetImage('assets/img/user.png') as ImageProvider,
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  user.username,
                  style: TextStyle(fontSize: 13),
                ),
                
                Text(
                  "${user.nbrflowers} followers",
                  style: TextStyle(fontSize: 11,color: const Color.fromARGB(255, 98, 98, 98)),
                ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
