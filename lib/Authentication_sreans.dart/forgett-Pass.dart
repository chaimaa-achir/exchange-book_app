// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/OTP_forgett.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  void sendOtp() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email address")),
      );
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse('https://books-paradise.onrender.com/auth/forget-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        if(mounted){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen(email: email)),
        );
        }
      } else {
        final message = jsonDecode(response.body)['message'];
         if(mounted){
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
         }
      }
    } catch (e) {
     if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error. Please try again later.")),
      );
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot your password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Enter your email to send the verification code.", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            myelvatedbottom(onPressed:sendOtp, child: Text("Send Code",style: TextStyle(fontSize: 18,color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
