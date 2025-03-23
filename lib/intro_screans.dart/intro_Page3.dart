// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 253, 247, 242),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
            SvgPicture.asset(
            "assets/img/page3.svg",
              height: MediaQuery.of(context).size.height*0.44,
              width: MediaQuery.of(context).size.width*0.4,
          ), 
            
           Container( 
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0.001),
              height: MediaQuery.of(context).size.height*0.033,
              width: MediaQuery.of(context).size.width*0.60,
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
             child: Text(
              "Rating & Community",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                       ),
           ),
          SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
            ),
         Center(
          child: 
          Text(
            "Rate users after each exchange to build a trusted community.",
            textAlign: TextAlign.center,
            style:TextStyle(
              fontSize: 17,
            ),
          ),
            
          ),
        ],
      ),
    );
  }
}
