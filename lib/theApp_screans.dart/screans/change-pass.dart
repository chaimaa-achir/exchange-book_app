// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> keyFromstate = GlobalKey<FormState>();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _matchpassword = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isPasswordVisible2 = true;
  bool _isPasswordVisible3 = true;
  bool isLoading = false;
  static Future<Map<String, dynamic>> changepass(
      String oldpass, String newpass) async {
    try {
      final url = 'https://books-paradise.onrender.com/auth/change-pass';
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.patch(Uri.parse(url),
          headers: headers,
          body: jsonEncode({'oldpass': oldpass, 'newpass': newpass}));
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'password updated.',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to update password.',
        };
      }
    } catch (e) {
      print('Exception in changing password: $e');
      throw Exception('Error changing password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: keyFromstate,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  " Change Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.09,
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(
                      "Enter your current Password",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextFormField(
                    controller: _currentPassword,
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0C3FC),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: _isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(
                      "Enter your new Password",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextFormField(
                    controller: _newpassword,
                    obscureText: _isPasswordVisible2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0C3FC),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible2 = !_isPasswordVisible2;
                            });
                          },
                          child: _isPasswordVisible2
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                    validator: (value) => pwdValidationFct(value),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(
                      "Re-type new Password",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextFormField(
                    controller: _matchpassword,
                    obscureText: _isPasswordVisible3,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0C3FC),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible3 = !_isPasswordVisible3;
                            });
                          },
                          child: _isPasswordVisible3
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                    validator: (value) =>
                        pwdConfirmValidationFct(value, _newpassword.text),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                myelvatedbottom(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final oldpass = _currentPassword.text;
                          final newpass = _newpassword.text;

                          if (keyFromstate.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            final response = await changepass(oldpass, newpass);

                            setState(() {
                              isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response['message'])),
                            );
                          }
                        },
                  child: isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Change Password",
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
