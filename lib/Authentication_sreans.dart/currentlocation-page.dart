// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLocationPAge extends StatefulWidget {
  const CurrentLocationPAge({super.key});

  @override
  State<CurrentLocationPAge> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPAge> {
  double? lat;
  double? lng;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.1),
            Center(
                child: Text(
              " Set yout location",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25),
            )),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: SizedBox(
                height: screenHeight * 0.9,
                width: screenWidth * 0.99,
                child: UserLocationMap(
                  onLocationPicked: (latitude, longitude) {
                    setState(() {
                      lat = latitude;
                      lng = longitude;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            myelvatedbottom(
                onPressed: () async {
                  if (lat != null && lng != null) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setDouble('latitude', lat!);
                    await prefs.setDouble('longitude', lng!);
                    // double? savedLat = prefs.getDouble('latitude');
                    // double? savedLng = prefs.getDouble('longitude');

                    // print("Saved Latitude: $savedLat");
                    // print("Saved Longitude: $savedLng");
                     if(mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Location saved!")),
                    );
                     }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please pick your location first")),
                    );
                  }
                },
                child:Text( "Ok",style: TextStyle(fontSize: 18,color: Colors.white))),
            SizedBox(height: screenHeight * 0.1),
          ],
        ),
      ),
    );
  }
}
