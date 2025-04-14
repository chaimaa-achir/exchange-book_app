import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/user.dart';
import 'package:mini_project/theApp_screans.dart/widgets/usercard.dart';


class Userdisplayhome extends StatelessWidget {
  const Userdisplayhome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
  
    return SizedBox(
      height: screenHeight*0.09,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Usercard(
              ontapUser: (){},
              user: users[index],
            );
          }),
    );
  }
}
