// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight =MediaQuery.of(context).size.height;
    final screenWidth =  MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 253, 247, 242),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center, // Center content vertically
        children: [
           SizedBox(
              height: screenHeight*0.15,
            ),
            SvgPicture.asset(
            "assets/img/page2.svg",
            height: screenHeight*0.4,
              width: screenWidth*0.4,
              
          ),
           SizedBox(
              height: screenHeight*0.06,
            ),// Add spacing
           Container(
          
             height: screenHeight*0.029,
              width: screenWidth*0.37,
              decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight: Radius.circular(12),topLeft:Radius.circular(9)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(-1, 12),
                              blurRadius:10,
                              spreadRadius: 1,


                            ),
                          ],
                        ),
             child: Text(
              "How it works",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                       ),
           ),
             SizedBox(
              height: screenHeight*0.04,
            ),
           Center(

            child: Text(
              "Add your book,search for book ,and start exchangig easily",
               textAlign: TextAlign.center,
               style: TextStyle(
                fontSize: 17,
               ),
               
              )
            ),
        ],
      ),
    );
  }
}
