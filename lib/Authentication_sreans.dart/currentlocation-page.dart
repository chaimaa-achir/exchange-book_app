// // ignore_for_file: file_names, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:mini_project/shared/costumeelevatedBottom.dart';
// import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CurrentLocationPAge extends StatefulWidget {
//   const CurrentLocationPAge({super.key});

//   @override
//   State<CurrentLocationPAge> createState() => _CurrentLocationPageState();
// }

// class _CurrentLocationPageState extends State<CurrentLocationPAge> {
//   double? lat;
//   double? lng;
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.1),
//             Center(
//                 child: Text(
//               " Set yout location",
//               textAlign: TextAlign.start,
//               style: TextStyle(fontSize: 25),
//             )),
//             SizedBox(height: screenHeight * 0.02),
//             Expanded(
//               child: SizedBox(
//                 height: screenHeight * 0.9,
//                 width: screenWidth * 0.99,
//                 child: UserLocationMap(
//                   onLocationPicked: (latitude, longitude) {
//                     setState(() {
//                       lat = latitude;
//                       lng = longitude;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             myelvatedbottom(
//                 onPressed: () async {
//                   if (lat != null && lng != null) {
//                     final prefs = await SharedPreferences.getInstance();
//                     await prefs.setDouble('latitude', lat!);
//                     await prefs.setDouble('longitude', lng!);
//                     // double? savedLat = prefs.getDouble('latitude');
//                     // double? savedLng = prefs.getDouble('longitude');

// ignore_for_file: deprecated_member_use, file_names

//                     // print("Saved Latitude: $savedLat");
//                     // print("Saved Longitude: $savedLng");
//                      if(mounted){
//                       ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Location saved!")),
//                     );
//                      }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("Please pick your location first")),
//                     );
//                   }
//                 },
//                 child:Text( "Ok",style: TextStyle(fontSize: 18,color: Colors.white))),
//             SizedBox(height: screenHeight * 0.1),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_project/theApp_screans.dart/screans/home.dart';

class CurrentLocationPage extends StatefulWidget {
  const CurrentLocationPage({super.key});

  @override
  State<CurrentLocationPage> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  double? lat;
  double? lng;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Location",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.02,
            ),
            child: const Text(
              "We use your location to show nearby books!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
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
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              bottom: screenHeight * 0.05,
              top: screenHeight * 0.02,
            ),
            child: myelvatedbottom(
              onPressed: _handleLocationPressed, // نادينا الدالة مباشرة بدون async هنا
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLocationPressed() async {
    if (lat != null && lng != null) {
      setState(() => _isLoading = true);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', lat!);
      await prefs.setDouble('longitude', lng!);

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Homesrean()),
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please wait while we detect your location"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
