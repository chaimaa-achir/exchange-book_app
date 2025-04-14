// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(255, 253, 247, 242),
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
          children: [
            SizedBox(
              height: screenHeight*0.1,
            ),
            SvgPicture.asset(
              "assets/img/page1.svg",
              height: screenHeight*0.5,
              width: screenWidth*0.4,
            ),
            Container(
              height: screenHeight*0.028,
              width: screenWidth*0.29,
              decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),topLeft:Radius.circular(9)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(-1, 12),
                              blurRadius: 10,
                               spreadRadius: 1, 


                            ),
                          ],
                        ),
              child: Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20),)

              ),
            SizedBox(
              height: screenHeight*0.06,
            ),
             Center(
              child: Text(
                     "Welcome to the Book Exchange App! Save money and share knowledge. ",
                     textAlign: TextAlign.center,
                     style: TextStyle(fontSize:17),
                   
                  
                   ),
                   ),
          ],
        ),
      ),
    );
  }
}
