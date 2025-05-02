// ignore_for_file: deprecated_member_use, file_names, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/asklocation.scree.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Verifycode extends StatefulWidget {
  final String email;
  const Verifycode({super.key, required this.email});

  @override
  State<Verifycode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<Verifycode> {
  final TextEditingController _otpcontroller = TextEditingController();
  bool _isLoading = false;

  Future<void> saveUserData(String token, Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();

  // تحويل بيانات المستخدم إلى JSON لتخزينها
  String userJson = json.encode(user);

  await prefs.setString('token', token); // تخزين التوكين
  await prefs.setString('user', userJson); // تخزين بيانات المستخدم

  // للتأكد بعد الحفظ
  print('تم حفظ التوكين: ${prefs.getString('token')}');
  print('تم حفظ بيانات المستخدم: ${prefs.getString('user')}');
}

Future<http.Response> verifyEmail(String email, String confirmationCode) async {
  final url =
      Uri.parse('https://books-paradise.onrender.com/auth/verify-email');
  return await http.patch(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'email': email,
      'confirmationCode': confirmationCode,
    }),
  );
}
  Future<void> handleVerify() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String otp = _otpcontroller.text;
      if (otp.isEmpty || otp.length < 6) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter a valid Code'),
            ),
          );
        }
        return;
      }

      final response = await verifyEmail(widget.email, otp);
      final responseBody = json.decode(response.body);

      if (mounted) {
        if ((response.statusCode == 200 || responseBody['success'] == true)) {
          // Save the user data after a successful verification
          final token = responseBody['token'];
        final user = responseBody['user'];
        await saveUserData(token, user);

          // Check location permission and navigate accordingly
          LocationPermission permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AsklocationsPage(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Navigationbar(),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                responseBody['message'] ?? 'Verification failed',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> resendConfirmationCode(String email) async {
    final url = Uri.parse(
        'https://books-paradise.onrender.com/auth/resend-confirmation-code');

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      final responseData = json.decode(response.body);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Code resent!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Something went wrong. Please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  "Verify email",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Check your email for the verification code.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139),
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 160, 107, 186),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    controller: _otpcontroller,
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveFillColor: Colors.grey[400]!,
                      activeFillColor: const Color.fromARGB(255, 238, 212, 250),
                      selectedFillColor:
                          const Color.fromARGB(255, 160, 107, 186),
                      inactiveColor: Colors.transparent,
                      activeColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    enableActiveFill: true,
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 139, 139, 139),
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await resendConfirmationCode(widget.email);
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      color: Color.fromARGB(255, 160, 107, 186),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                _isLoading
                    ? const CircularProgressIndicator()
                    : myelvatedbottom(
                        onPressed: handleVerify,
                        child: const Text(
                          "Verify",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
