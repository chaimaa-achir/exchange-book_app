import 'package:flutter/material.dart';

class myelvatedbottom extends StatelessWidget {
  const myelvatedbottom({super.key,required this.onPressed,required this.text});
  final VoidCallback? onPressed;
  final String text;

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
        child: Text(
          text,
          style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
