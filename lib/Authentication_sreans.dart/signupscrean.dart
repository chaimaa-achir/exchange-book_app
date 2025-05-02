// ignore_for_file: deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert'; // For json.encode / decode
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/login.dart';
import 'package:mini_project/Authentication_sreans.dart/termandconditions.dart';
import 'package:mini_project/Authentication_sreans.dart/verifyCode.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For making HTTP requests

class Signupscrean extends StatefulWidget {
  const Signupscrean({super.key, required this.isAgree});
  final bool isAgree;

  @override
  State<Signupscrean> createState() => _SignupscreanState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _fullnameController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

class _SignupscreanState extends State<Signupscrean> {
  bool _isPasswordVisible = true;
  bool _isPasswordVisible2 = true;
  bool isChecked = false;
  String? email;

  // For UI elements like ScaffoldMessengerqw
  Future<Map<String, dynamic>> registerUser({
    required String fullname,
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('https://books-paradise.onrender.com/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "username": username,
          "password": password,
          "fullname": fullname,
        }),
      );

      if (response.statusCode == 201) {
        return {"success": true, "data": json.decode(response.body)};
      } else {
        final error = json.decode(response.body)['message'];
        return {"success": false, "message": error ?? "Registration failed"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  void _updateCheckboxState(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAgree) {
      _updateCheckboxState(true);
    }
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                  //height: 20,
                ),
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27,
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "fill your information below or register\nwith your social account ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139),
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Full name",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: screenHeight * 0.05,
                  child: TextField(
                    controller: _fullnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "UserName",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: screenHeight * 0.05,
                  child: TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Email",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: screenHeight * 0.05,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "example@gmail.com",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Password",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: screenHeight * 0.05,
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: _isPasswordVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Confirm password",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: screenHeight * 0.05,
                  child: TextField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _isPasswordVisible2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible2 = !_isPasswordVisible2;
                          });
                        },
                        child: _isPasswordVisible2
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.0001),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.009),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color.fromARGB(255, 160, 107, 186),
                      side: BorderSide(
                        // Customize the border
                        color: Color.fromARGB(
                          255,
                          160,
                          107,
                          186,
                        ), // Border color
                        width: 2.0, // Border thickness
                      ),
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),
                    Text("Agree with ", style: TextStyle(fontSize: 13)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsAndConditionsPage(
                                  // onAgree: _updateCheckboxState,
                                  )),
                        );
                      },
                      child: Text(
                        "Terms and Conditions ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 160, 107, 186),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),

                // myelvatedbottom(
                //  child:Text("Sign up" ,style: TextStyle(fontSize: 18,color: Colors.white)) ,
                //   onPressed: () async {
                //     final fullname = _fullnameController.text.trim();
                //     final username = _usernameController.text.trim();
                //     final emailUser = _emailController.text.trim();
                //     final password = _passwordController.text.trim();
                //     final confirmPassword =_confirmPasswordController.text.trim();

                //     if (!isChecked) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(
                //             "Please agree to the Terms and Conditions",
                //           ),
                //         ),
                //       );
                //       return;
                //     }

                //     if (fullname.isEmpty ||
                //         username.isEmpty ||
                //         emailUser.isEmpty ||
                //         password.isEmpty ||
                //         confirmPassword.isEmpty) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text("Please fill all fields")),
                //       );
                //       return;
                //     }

                //     if (password != confirmPassword) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text("Passwords do not match")),
                //       );
                //       return;
                //     }

                //     final result = await registerUser(
                //       fullname: fullname,
                //       username: username,
                //       email: emailUser,
                //       password: password,

                //     );

                //     if (result['success']) {
                //       if (!context.mounted) return;
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Verifycode(email: emailUser),
                //         ),
                //       );
                //     } else {
                //        if(mounted){
                //           ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text(result['message'])),
                //       );
                //        }
                //     }
                //   },
                // ),
                myelvatedbottom(
                  child: Text("Sign up",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  onPressed: () async {
                    final fullname = _fullnameController.text.trim();
                    final username = _usernameController.text.trim();
                    final emailUser = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final confirmPassword =
                        _confirmPasswordController.text.trim();

                    if (!isChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Please agree to the Terms and Conditions"),
                        ),
                      );
                      return;
                    }

                    if (fullname.isEmpty ||
                        username.isEmpty ||
                        emailUser.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    final result = await registerUser(
                      fullname: fullname,
                      username: username,
                      email: emailUser,
                      password: password,
                    );

                    if (result['success']) {
                      // Registration successful, navigate to the VerifyCode screen
                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Verifycode(email: emailUser),
                        ),
                      );
                    } else {
                      // Show error message in SnackBar first
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result['message'])),
                        );
                        // Add a delay to ensure the user sees the error before navigating
                        await Future.delayed(Duration(seconds: 2));
                      }
                      // Prevent navigation if the registration fails
                    }
                  },
                ),

                SizedBox(height: screenHeight * 0.037),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31,
                      child: Divider(thickness: 1, color: Colors.black54),
                    ),
                    Text(
                      "Or Sign up with",
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31,
                      child: Divider(thickness: 1, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/img/google.svg",
                          height: screenHeight * 0.047,
                          width: MediaQuery.of(context).size.width * 0.047,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/img/apple.svg",
                          height: screenHeight * 0.047,
                          width: MediaQuery.of(context).size.width * 0.047,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                    InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                offset: Offset(5, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            "assets/img/fac.svg",
                            height: screenHeight * 0.047,
                            width: MediaQuery.of(context).size.width * 0.047,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "you already have an account? ",
                      style: TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginscrean(),
                          ),
                        );
                      },
                      child: Text(
                        "Log in ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 160, 107, 186),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
