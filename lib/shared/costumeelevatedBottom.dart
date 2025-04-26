// ignore_for_file: file_names, camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';

class myelvatedbottom extends StatelessWidget {
  const myelvatedbottom({super.key,required this.onPressed,required this.child});
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 158, 107, 183), // Button color
          padding: EdgeInsets.all(8), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Rounded corners
          ),
          elevation: 8, // Shadow effect
          shadowColor: Colors.deepPurple.withOpacity(0.9), // Shadow color
        ),
        child:child,
      ),
    );
  }
}
