// import 'package:flutter/material.dart';
// import 'package:mini_project/theApp_screans.dart/models/book.dart';

// import 'package:mini_project/theApp_screans.dart/models/catigory.dart';
// import 'package:mini_project/theApp_screans.dart/screans/book-details.dart';
// import 'package:mini_project/theApp_screans.dart/widgets/bookcard.dart';



// class CategoryScreen extends StatelessWidget {
//   final Catigory catigory;
//   const CategoryScreen({super.key, required this.catigory});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     List<Book> filteredBooks = 
//         books.where((book) =>
//             book.category.toLowerCase() == catigory.catigoryName.toLowerCase())
//         .toList();

//     return Scaffold(
//         appBar: AppBar(
//           elevation: 18,
//           title: Text(catigory.catigoryName),
//         ),
//         body: filteredBooks.isEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Oops!", style: TextStyle(fontSize: 20)),
//                     SizedBox(
//                       height: screenHeight * 0.03,
//                     ),
//                     Text(
//                       textAlign: TextAlign.center,
//                       "There are no books available in this category.",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               )
//             : ListView.builder(
//                 scrollDirection: Axis.vertical, // Ensure vertical scrolling
//                 itemCount:
//                     (filteredBooks.length / 2).ceil(), // Each row has 2 books
//                 itemBuilder: (context, index) {
//                   int firstBookIndex = index * 2;
//                   int secondBookIndex = firstBookIndex + 1;

//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Bookcard(
//                         ontapbook: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BookDetails(
//                                   book: filteredBooks[firstBookIndex]),
//                             ),
//                           );
//                         },
//                         ontapowner: () {},
//                         book: filteredBooks[firstBookIndex],
//                       ),
//                       SizedBox(width: 10), // Space between books
//                       if (secondBookIndex <
//                           filteredBooks.length) // Ensure we don't overflow
//                         Bookcard(
//                           ontapbook: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BookDetails(
//                                     book: filteredBooks[secondBookIndex]),
//                               ),
//                             );
//                           },
//                           ontapowner: () {},
//                           book: filteredBooks[secondBookIndex],
//                         ),
//                     ],
//                   );
//                 },
//               ));
//   }
// }
