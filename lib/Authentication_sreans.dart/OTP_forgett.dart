// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/resetPassword.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  const OTPScreen({required this.email, super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isResendDisabled = false;

  // Verify OTP functionality
  void verifyOtp() async {
    String otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the verification code")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://books-paradise.onrender.com/auth/verify-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'resetCode': otp,
        }),
      );

      if (response.statusCode == 200) {
        if(mounted){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: widget.email),
          ),
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
      print("$e");
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error. Please try again later.")),
      );
      }
    }
  }

  // Resend OTP functionality
  void resendOtp() async {
  setState(() {
    isResendDisabled = true; // Disable the button to prevent spamming
  });

  try {
    final response = await http.patch(
      Uri.parse('https://books-paradise.onrender.com/auth/resend-reset-code'), // Updated URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}),
    );

    if(mounted){
      if (response.statusCode == 200) {
      final message = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      final message = jsonDecode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
    }
  } catch (e) {
    print("$e");
    if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Server error. Please try again later.")),
    );
    }
  }

  // Re-enable the button after 30 seconds
  Future.delayed(const Duration(seconds: 30), () {
    setState(() {
      isResendDisabled = false;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter verification code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "The verification code has been sent to ${widget.email}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter verification code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            myelvatedbottom(onPressed: verifyOtp, child:Text("Check the code", style: TextStyle(fontSize: 18,color: Colors.white)) ),
            const SizedBox(height: 20),
            // Resend OTP Button
            ElevatedButton(
              onPressed: isResendDisabled ? null : resendOtp,
              child: Text(isResendDisabled ? "Resend in 30s" : "Resend Code"),
            ),
          ],
        ),
      ),
    );
  }
}


