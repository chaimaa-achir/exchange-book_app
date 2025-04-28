// // ignore_for_file: deprecated_member_use, file_names, unused_local_variable, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mini_project/Authentication_sreans.dart/asklocation.scree.dart';
// import 'package:mini_project/shared/costumeelevatedBottom.dart';
// import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
// import 'dart:convert';

// //import 'package:mini_project/theApp_screans.dart/home_page.dart';

// import 'package:pin_code_fields/pin_code_fields.dart';

// Future<http.Response> verifyEmail(String email, String confirmationCode) async {
//   final url =
//       Uri.parse('https://books-paradise.onrender.com/auth/verify-email');
//   return await http.patch(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({
//       'email': email,
//       'confirmationCode': confirmationCode,
//     }),
//   );
// }

// class Verifycode extends StatefulWidget {
//   final String email;
//   const Verifycode({super.key, required this.email});

//   @override
//   State<Verifycode> createState() => _VerifyCodeState();
// }

// final TextEditingController _otpcontroller = TextEditingController();

// class _VerifyCodeState extends State<Verifycode> {
//   Future<void> resendConfirmationCode(String email) async {
//     final url = Uri.parse(
//         'https://books-paradise.onrender.com/auth/resend-confirmation-code');

//     try {
//       final response = await http.patch(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'email': email}),
//       );

//       final responseData = json.decode(response.body);
//        if(mounted){
//           if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(responseData['message'])),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(responseData['message'])),
//         );
//       }
//        }
//     } catch (e) {
//        if(mounted){
//         ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Something went wrong. Please try again.")),
//       );
//        }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.05,
//                 //height: 20,
//               ),
//               Text(
//                 "Verify your code",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 27),
//               ),
//               Center(
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   "Please enter the code that we just send it to your email. ",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
//                 ),
//               ),
//               Text(
//                 widget.email,
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 160, 107, 186),
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.08,
//               ),
//               PinCodeTextField(
//                 controller: _otpcontroller,
//                 appContext: context,
//                 length: 6,
//                 keyboardType: TextInputType.number,
//                 animationType: AnimationType.fade,
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(12), // Rounded corners
//                   fieldHeight: 40,
//                   fieldWidth: 37, // Adjust size to match design

//                   inactiveFillColor: Colors.grey[400]!, // Light gray fill
//                   activeFillColor:
//                       Color.fromARGB(255, 238, 212, 250), // White when active
//                   selectedFillColor:
//                       Color.fromARGB(255, 160, 107, 186), // White when typing

//                   inactiveColor: Colors.transparent, // No border
//                   activeColor: Colors.transparent,
//                   selectedColor: Colors.transparent,
//                 ),
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 enableActiveFill: true,
//                 onChanged: (value) {},
//               ),
//               SizedBox(
//                 height: screenHeight * 0.03,
//               ),
//               Text(
//                 "didn't receive the OTP?",
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   await resendConfirmationCode(widget.email);
//                 },
//                 child: Text(
//                   "Resend code",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 160, 107, 186),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.03,
//               ),
              
//                myelvatedbottom(
//                 child: Text( "Verify",style: TextStyle(fontSize: 18,color: Colors.white)),
//                 onPressed:  ()async {
//                     String otp = _otpcontroller.text;
//                     if (otp.isEmpty || otp.length < 6) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Please enter a valid Code')),
//                       );
//                       return;
//                     }

//                     final response = await verifyEmail(widget.email, otp);

//                     if (response.statusCode == 200) {
//                      if(mounted){
//                         Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) =>AsklocationsPage()),
//                       );
//                      }
//                     } else {
//                       final errorMessage =
//                           json.decode(response.body)['message'];
//                        if(mounted){
//                         ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(errorMessage)),
//                       );
//                        }
//                     }
//                   },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use, file_names, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/Authentication_sreans.dart/asklocation.scree.dart';
//import 'package:mini_project/intro_screans.dart/onbording_screan.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

//import 'package:mini_project/theApp_screans.dart/home_page.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

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

class Verifycode extends StatefulWidget {
  final String email;
  const Verifycode({super.key, required this.email});

  @override
  State<Verifycode> createState() => _VerifyCodeState();
}

final TextEditingController _otpcontroller = TextEditingController();

class _VerifyCodeState extends State<Verifycode> {
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
       if(mounted){
          if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
       }
    } catch (e) {
       if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong. Please try again.")),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.05,
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
                  "Please enter the code that we just send it to your email. ",
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
                height: screenHeight * 0.08,
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
                height: screenHeight * 0.03,
              ),
              Text(
                "didn't receive the OTP?",
                style: TextStyle(
                    color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
              ),
              GestureDetector(
                onTap: () async {
                  await resendConfirmationCode(widget.email);
                },
                child: Text(
                  "Resend code",
                  style: TextStyle(
                    color: Color.fromARGB(255, 160, 107, 186),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              
               myelvatedbottom(
                child: Text( "Verify",style: TextStyle(fontSize: 18,color: Colors.white)),
                onPressed:  ()async {
                    String otp = _otpcontroller.text;
                    if (otp.isEmpty || otp.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid Code')),
                      );
                      return;
                    }

                    final response = await verifyEmail(widget.email, otp);

                    if (response.statusCode == 200) {
                     if(mounted){
                        LocationPermission permission = await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied) {
                        
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>AsklocationsPage()),
                      );
                     }
                     else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>Navigationbar()),
                      );
                     }
                     }
                    } else {
                      final errorMessage =
                          json.decode(response.body)['message'];
                       if(mounted){
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                       }
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
