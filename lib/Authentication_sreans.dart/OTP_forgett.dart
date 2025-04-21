
import 'package:flutter/material.dart';
import 'package:mini_project/Authentication_sreans.dart/resetPassword.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
class OTPScreen extends StatefulWidget {
  final String email;

  const OTPScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  void verifyOtp() {
    String otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter the verification code")),
      );
      return;
    }

    // تحقق من الـ OTP من خلال السيرفر
    // لو صحيح، انتقل لشاشة إدخال كلمة المرور الجديدة
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(email: widget.email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter verification code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("The verification code has been sent to${widget.email}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter verification code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: verifyOtp,
            //   child: Text("تحقق من الرمز"),
            // ),
            myelvatedbottom(onPressed: verifyOtp, text: "Check the code")
          ],
        ),
      ),
    );
  }
}
