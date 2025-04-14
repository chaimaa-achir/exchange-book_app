// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project/Authentication_sreans.dart/login.dart';
import 'package:mini_project/Authentication_sreans.dart/verifyCode.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';


class Signupscrean extends StatefulWidget {
  const Signupscrean({super.key});

  @override
  State<Signupscrean> createState() => _SignupscreanState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _fullnameController = TextEditingController();

class _SignupscreanState extends State<Signupscrean> {
  bool _isPasswordVisible = true;
  bool isChecked = false;
  String? email;
  @override
  Widget build(BuildContext context) {
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
                      fontSize: 27),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "fill your information below or register\nwith your social account ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.004,
                ),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                SizedBox(
                  height: screenHeight * 0.004,
                ),
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                              : Icon(Icons.visibility)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.004,
                ),
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0001,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.009,
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color.fromARGB(255, 160, 107, 186),
                      side: BorderSide(
                        // Customize the border
                        color:
                            Color.fromARGB(255, 160, 107, 186), // Border color
                        width: 2.0, // Border thickness
                      ),
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),
                    Text(
                      "Agree with ",
                      style: TextStyle(fontSize: 13),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "Terms and Conditions ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 160, 107, 186),
                              fontSize: 13),
                        )),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
              
                 myelvatedbottom(
                  text: "Sign up",
                  onPressed:() async {
                      final String fullname = _fullnameController.text.trim();
                      final String emailUser = _emailController.text.trim();

                      if (emailUser.isNotEmpty && fullname.isNotEmpty) {
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Verifycode(email: emailUser)),
                        );
                      }
                    }, 
                 ),
                SizedBox(
                  height: screenHeight * 0.037,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31,
                      child: Divider(thickness: 1, color: Colors.black54),
                    ),
                    Text(
                      "Or Sign up with",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31,
                      child: Divider(thickness: 1, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
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
                SizedBox(
                  height: screenHeight * 0.04,
                ),
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
                                builder: (context) => Loginscrean()),
                          );
                        },
                        child: Text("Log in ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 160, 107, 186),
                                fontWeight: FontWeight.bold,
                                fontSize: 14))),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
