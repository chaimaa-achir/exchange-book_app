// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:mini_project/theApp_screans.dart/models/catigory.dart';
// import 'package:mini_project/theApp_screans.dart/screans/categoryscreen.dart';
// import 'package:mini_project/theApp_screans.dart/widgets/catigorybutton.dart';



// class Catigorydisplay extends StatelessWidget {
//   const Catigorydisplay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

    // ignore_for_file: file_names
    
//     return SizedBox(
//       height: screenHeight*0.09,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: catigories.length,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Catigorybutton(
//                ontap: (){
//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CategoryScreen (
//                   catigory:catigories[index],
//                   )
//                 )
//                 );
//                },
//                catigory: catigories[index],
//             );
//           }),
//     );
//   }
// }
