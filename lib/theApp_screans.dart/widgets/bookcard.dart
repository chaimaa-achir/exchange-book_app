// ignore_for_file: deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mini_project/helpers/string_utils.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bookcard extends StatelessWidget {
  final Book book;
  final VoidCallback ontapbook;
  final VoidCallback ontapowner;
  const Bookcard(
      {Key? key,
      required this.book,
      required this.ontapbook,
      required this.ontapowner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final String booktitle = book.booktitel;
    final String ownername = book.ownername;
    final String ownerimage = book.ownerimage;
    final String bookimage = book.bookimage;
    final String distence = book.distence;
    final String bookstatue = book.bookstatus;
    //  final String category = book.category;
    //final String? description = book.description;

    final bool availability = book.availability;
    final statusColor = bookstatue == "Exchange"
        ? Colors.blue
        : book.bookstatus == "Lending"
            ? Colors.green
            : book.bookstatus == "Sale"
                ? Colors.orange
                : Colors.grey;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.4,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: const Color.fromARGB(255, 211, 209, 209),
                    offset: Offset(5, 7),
                    blurRadius: 10,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // book image
                GestureDetector(
                  onTap: ontapbook,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.asset(
                          bookimage,
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.4,
                          fit: BoxFit.cover,
                        ),
                        if (!availability) // Apply blur only if book is unavailable
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 5, sigmaY: 5), // Blur effect
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
                                alignment:
                                    Alignment.center, // Slight dark overlay
                                child: const Text(
                                  "Not Available",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(168, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booktitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ontapowner,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(ownerimage),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Expanded(
                        child: Text(
                          ownername,
                          style: TextStyle(fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 78,
            right: 7.5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 64, 64),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                distence,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 6,
                ),
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                bookstatue,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 7,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
