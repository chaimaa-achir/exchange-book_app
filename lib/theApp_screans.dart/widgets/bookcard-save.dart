import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'dart:ui';



class Bookcard_save extends StatelessWidget {
  final Book book;
  final VoidCallback ontapbook;
  const Bookcard_save({super.key, required this.book,required this.ontapbook});

  @override
  Widget build(BuildContext context) {
    
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            width: double.infinity,
            height:screenHeight * 0.14,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 110, 109, 109),
                    offset: Offset(5, 7),
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ontapbook,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(20), 
                      bottomLeft: Radius.circular(20),
                    ),
                    child:Stack(
                      children: [
                         SizedBox(
                      width:screenWidth*0.35,
                      height: double.infinity, 
                      child: Image.asset(
                         book.bookimage,
                        fit: BoxFit.cover, 
                      ),
                    ),
                    if (!book.availability) // Apply blur only if book is unavailable
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 5, sigmaY: 5), // Blur effect
                            child: Container(
                              color: Colors.black.withOpacity(0.2),
                              alignment:
                                  Alignment.center, // Slight dark overlay
                              child: Text(
                                "Not Available",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: book.bookstatus == "Exchange"
                      ? Colors.blue
                      : book.bookstatus == "Lending"
                          ? Colors.green
                          : book.bookstatus == "Sale"
                              ? Colors.orange
                              : Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                child: Text(
                                    book.bookstatus,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7,
                                    ),),),
                          Text(
                            book.booktitel,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height:screenHeight * 0.001,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundImage: AssetImage(book.ownerimage),
                              ),
                              SizedBox(
                                width:screenWidth* 0.01,
                              ),
                              Text(
                                book.ownername,
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                width:screenWidth* 0.01,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(
                               "4.6",// i need to find solutiond here ratig is double but the text is string 
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.deepOrange,
                            size: 17,
                          ),
                          Text(
                             book.distence,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
