import 'package:flutter/material.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:Column(

          children: [
              SizedBox(
            height:screenHeight*0.1
            ),
            Center(child: Text(" Set yout location",textAlign: TextAlign.start,style: TextStyle(fontSize:25),)),
            SizedBox(
            height:screenHeight*0.02
            ),
          Expanded(
            child:SizedBox(
                 
                height: screenHeight*0.9,
                width: screenWidth*0.99,
              //  child: CurrentUserLocation(),
              ),
          ),   SizedBox(
            height:screenHeight*0.02
            ),
          myelvatedbottom(onPressed: (){}, 
          text: "Ok"),
            SizedBox(
            height:screenHeight*0.1
            ),
          ],
        ),
      ),
    );
  }
}
