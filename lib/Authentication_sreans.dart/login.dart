// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project/Authentication_sreans.dart/signupscrean.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';



class Loginscrean extends StatefulWidget {
  const Loginscrean({super.key});

  @override
  State<Loginscrean> createState() => _LoginscreanState();
}

class _LoginscreanState extends State<Loginscrean> {

  bool _isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth =MediaQuery.of(context).size.width;
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
                height: screenHeight *0.150,
                //height: 20,
                ),
                Text(
                  
                  "Log In",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 27),
                ),
                
                Text(
                  "Hi welcome back!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 139, 139, 139), fontSize: 12),
                ),
                SizedBox(
                height: screenHeight *0.06,
                
                ),
                FractionallySizedBox(
                  widthFactor:0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Email",
                    style: TextStyle(fontSize:15,color: Colors.black54),
                  ),
                ),
              SizedBox(
                  width:screenWidth *0.9,
                  height: screenHeight *0.05,
                  child: TextField(
                  
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal:10 ,vertical:7),
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
                  height: screenHeight *0.02
                ),
                FractionallySizedBox(
                  widthFactor:0.9,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Password",
                    style: TextStyle(fontSize:15,color: Colors.black54),
                  ),
                ),
                SizedBox(
                  
                  width:screenWidth *0.9,
                  height: screenHeight *0.05,
                  child: TextField(
                    
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal:10 ,vertical:7),
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
                          child:   _isPasswordVisible?
                          Icon(Icons.visibility_off)
                          :  Icon(Icons.visibility)
                      ),
                      
                    ),
                    
                  ),
                ),
                SizedBox(
                  height: screenHeight*0.0090,
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: InkWell(
                    onTap:(){},
                    child: Text("Forget Password?",
                                 textAlign: TextAlign.right,
                           style: TextStyle(color:Color.fromARGB(255, 160, 107, 186)),
                    )),
                ),
                SizedBox(
                  height: screenHeight*0.05,
                ),
                myelvatedbottom(
                  text:"Log in",
                  onPressed: (){},
                ),
                SizedBox(
                  height: screenHeight*0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                     width:screenWidth*0.31,
                      child: Divider(
                        thickness:1,
                        color: Colors.black54
                      ),
                    ),
                    Text(
                      "Or Log in with",
                      style: 
                      TextStyle(
                        fontSize:11,
                        color: Colors.black54,
                      ),
                      
                    ),
                      SizedBox(
                        width:screenWidth*0.31,
                      child: Divider(
                        thickness:1,
                        color: Colors.black54
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: screenHeight*0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(5, 5),
                              blurRadius:10,


                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/img/google.svg",
                          height:screenHeight* 0.047,
                          width:screenWidth* 0.047,
                          ),
                      ),
                    ),
                      SizedBox(
                        width:screenWidth* 0.12,
                      ),
                    InkWell(
                      onTap:(){},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(5, 5),
                              blurRadius:10,


                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/img/apple.svg",
                          height:screenHeight*  0.047,
                          width:screenWidth* 0.047,
                        ),
                      ),
                    ),
                      SizedBox(
                        width:screenWidth* 0.12,
                      ), 
                    InkWell(
                      onTap:(){},
                      child: InkWell(
                        onTap:(){},
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(5, 5),
                              blurRadius:10,


                            ),
                          ],
                        ),
                          child: SvgPicture.asset(
                          "assets/img/fac.svg",
                            height:screenHeight*  0.047,
                            width:screenWidth* 0.047,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: screenHeight*0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? ",style: TextStyle(fontSize: 12),),
                  GestureDetector(
                    onTap:(){
                        Navigator.push(
                             context,
                          MaterialPageRoute(builder: (context) => Signupscrean()),
                               );
                    },
                      child: Text(
                        "Sing up",
                        style: TextStyle(color: Color.fromARGB(255, 160, 107, 186),fontWeight:FontWeight.bold,fontSize:14)
                        )
                        ),
                    
                  ],
                ),
                  
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
