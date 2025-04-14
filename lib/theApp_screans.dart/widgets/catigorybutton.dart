// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/catigory.dart';



class Catigorybutton extends StatelessWidget {

  final Catigory catigory;

  final VoidCallback ontap;
const Catigorybutton({super.key, required this.ontap,required this.catigory});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.only(left: 9),
          height: screenHeight * 0.07,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFB8A4E0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 171, 170, 170),
                  offset: Offset(2, 2),
                  blurRadius: 10,
                ),
              ]),
          alignment: Alignment.center,
          child: Text(
            catigory.catigoryName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
