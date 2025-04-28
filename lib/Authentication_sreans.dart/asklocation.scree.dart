// import 'package:flutter/material.dart';
// import 'package:mini_project/Authentication_sreans.dart/currentlocation-page.dart';
// import 'package:mini_project/shared/costumeelevatedBottom.dart';


// class AsklocationsPage extends StatelessWidget {
//   const AsklocationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("👋",style: TextStyle(fontSize: 35),),
//             Text("Hi,Username",style: TextStyle(fontSize:30),),
//             Center(child: Text(" Before u can share your books , we need to know your location",style: TextStyle(fontSize:23),textAlign: TextAlign.center,)),
//               SizedBox(
//             height: MediaQuery.of(context).size.height*0.01
//             ),
//             RichText(
//               textAlign: TextAlign.center,
              
//               text: TextSpan(
//               style: TextStyle(color: Colors.black ,fontSize: 15),
//               children: [
//                 TextSpan(
//                   text: "So we can show "
//                 ),
//                 TextSpan(
//                   text: "nearby listing ",
//                   style: TextStyle(color: Color.fromARGB(255, 160, 107, 186)),
//                 ),
//                 TextSpan(
//                   text: ",& how many"
//                 ),
//                 TextSpan(
//                   text: " other people",
//                   style: TextStyle(color: Color.fromARGB(255, 160, 107, 186)),
//                 ),
//                 TextSpan(
//                   text: " are waiting to share with u",
//                 ),
//               ],
//             )),
//             SizedBox(
//             height: MediaQuery.of(context).size.height*0.1
//             ),
//              myelvatedbottom(
//               onPressed: (){
//                 Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CurrentLocationPAge()),
//                           );
//               },
//             child: Text("Ok, let's go",style: TextStyle(fontSize: 18,color: Colors.white)),
//              ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mini_project/Authentication_sreans.dart/currentlocation-page.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';

class AsklocationsPage extends StatelessWidget {
  const AsklocationsPage({super.key});

  Future<void> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location services'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are required'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enable permissions in app settings'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CurrentLocationPage ()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                "👋",
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Hi there!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                "Help us connect you with book lovers nearby!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.4,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                  children: const [
                    TextSpan(text: "See what books are available "),
                    TextSpan(
                      text: "in your area ",
                      style: TextStyle(
                        color: Color(0xFF9C27B0), // Purple accent
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: "and connect with readers "),
                    TextSpan(
                      text: "near you :)",
                      style: TextStyle(
                        color: Color(0xFF9C27B0), // Matching purple
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //TextSpan(text: "are waiting to share with you"),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: myelvatedbottom(
                  onPressed: () => _handleLocationPermission(context),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}