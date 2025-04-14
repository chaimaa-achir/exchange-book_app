// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'package:mini_project/theApp_screans.dart/screans/home.dart';
//import 'package:mini_project/theApp_screans.dart/home_page.dart';

import 'package:pin_code_fields/pin_code_fields.dart';



class Verifycode extends StatefulWidget {
  final String email;
  const Verifycode({super.key, required this.email});

  @override
  State<Verifycode> createState() => _VerifyCodeState();
}

final TextEditingController _otpcontroller = TextEditingController();

class _VerifyCodeState extends State<Verifycode> {
  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:screenHeight  * 0.05,
                //height: 20,
              ),
              Text(
                "Verify your code",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27),
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Please enter the code that we just send it to u ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
                ),
              ),
              Text(
                widget.email,
                style: TextStyle(
                    color: Color.fromARGB(255, 160, 107, 186),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenHeight  * 0.08,
              ),
              PinCodeTextField(
                controller: _otpcontroller,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  fieldHeight: 40,
                  fieldWidth: 37, // Adjust size to match design

                  inactiveFillColor: Colors.grey[400]!, // Light gray fill
                  activeFillColor:
                      Color.fromARGB(255, 238, 212, 250), // White when active
                  selectedFillColor:
                      Color.fromARGB(255, 160, 107, 186), // White when typing

                  inactiveColor: Colors.transparent, // No border
                  activeColor: Colors.transparent,
                  selectedColor: Colors.transparent,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                enableActiveFill: true,
                onChanged: (value) {},
              ),
              SizedBox(
                height: screenHeight  * 0.03,
              ),
              Text(
                "didn't receive the OTP?",
                style: TextStyle(
                    color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
              ),
              GestureDetector(onTap: () {}, child: Text("Resend code")),
              SizedBox(
                height: screenHeight  * 0.03,
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  onPressed: () async {
                    String optenter = _otpcontroller.text;
                    if (optenter.isEmpty || optenter.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a valid Code')));
                      return;
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homesrean()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 160, 107, 186), // Button color
                    padding: EdgeInsets.all(8), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                    elevation: 8, // Shadow effect
                    shadowColor:
                        Colors.deepPurple.withOpacity(0.9), // Shadow color
                  ),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            /*  myelvatedbottom(
                text: "Verify",
                onPressed:  () async {
                    String optenter = _otpcontroller.text;
                    if (optenter.isEmpty || optenter.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a valid Code')));
                      return;
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Navigationbar()),
                      );
                    }
                  },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
