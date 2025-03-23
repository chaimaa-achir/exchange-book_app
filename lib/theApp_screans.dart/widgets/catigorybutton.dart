// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Catigorybutton extends StatelessWidget {
  final String title;

  final VoidCallback ontap;
  Catigorybutton(
      {super.key,
      required this.title,
      required this.ontap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.only(left:9),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 230, 171, 255),
            ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
