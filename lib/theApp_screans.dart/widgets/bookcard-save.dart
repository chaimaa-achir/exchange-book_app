import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';
import 'dart:ui';

class Bookcard_save extends StatelessWidget {
  final Book book;
  final VoidCallback ontapbook;

  const Bookcard_save({super.key, required this.book, required this.ontapbook});

  @override
  Widget build(BuildContext context) {
    final savedProvider =
        Provider.of<SavedBooksProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            height: screenHeight * 0.14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 110, 109, 109),
                  offset: Offset(5, 7),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: ontapbook,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.35,
                          height: double.infinity,
                          child: Image.network(
                            book.bookimage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.broken_image),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                        if (!book.availability)
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
                                alignment: Alignment.center,
                                child: Text(
                                  "Not Available",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                  
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
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
                                ),
                              ),
                            ),
                            Text(
                              book.booktitel,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: screenHeight * 0.001),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius:12,
                                  backgroundImage: book.ownerimage != null
                                      ? NetworkImage(book.ownerimage!)
                                      : AssetImage("assets/img/user.png")
                                          as ImageProvider,
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Text(book.ownername,
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.deepOrange, size: 17),
                                  Text(
                                      book.distence != null
                                          ? '${book.distence} km'
                                          : 'Unknown',
                                      style: TextStyle(fontSize: 10)),
                                      
                                ],
                                
                              ),
                              
                              InkWell(
                                onTap:()async{
                                  await savedProvider.saveBook(book);
                                },
                                child: Icon(Icons.bookmark, color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
