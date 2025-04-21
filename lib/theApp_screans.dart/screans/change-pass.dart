import 'package:flutter/material.dart';
import 'package:mini_project/helpers/validator.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';

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
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                    onPressed: () {
                      if (keyFromstate.currentState!.validate()) {}
                      ;
                    },
                    text:"Change Password",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
