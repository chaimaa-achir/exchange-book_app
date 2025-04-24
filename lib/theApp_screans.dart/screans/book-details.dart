// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_project/helpers/time_utils.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/screans/request-screen.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';
//import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';

class BookDetails extends StatefulWidget {
  final Book book;

  const BookDetails({
    super.key,
    required this.book,
  });
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final savedBooksProvider = Provider.of<SavedBooksProvider>(context);
    final isSaved = savedBooksProvider.isSaved(widget.book);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitel),
        elevation: 18,
        actions: [
          IconButton(
              onPressed: () {
                showReportOptions(context, (selectedReason) {
                  print("the reason:$selectedReason");
                });
              },
              icon: Icon(
                Icons.flag_outlined,
                size: 30,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                child: Image.asset(
                  widget.book.bookimage,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.ios_share_outlined)),
                  Text(
                    "Share",
                    style: TextStyle(fontSize: 12),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          savedBooksProvider.toggleSaveBook(widget.book);
                        });
                      },
                      icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_outline)),
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(widget.book.ownerimage),
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.ownername,
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.start,
                            ),
                            Center(
                              child: Text(
                                widget.book.booktitel,
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              "added in ${timeAgo(widget.book.postDate)}",
                              style: TextStyle(
                                  fontSize: 9,
                                  color:
                                      const Color.fromARGB(255, 74, 72, 72)),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    if (widget.book.description != null)
                      Text(widget.book.description!),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    if (widget.book.bookstatus == "Sale") ...[
                      Text(
                        "Book price ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.book.price} DA",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                    ],
                    Text(
                      "Location",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            SizedBox(
              height: screenHeight * 0.29,
              width: screenWidth * 0.95,
              //child: CurrentUserLocation(),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            myelvatedbottom(
              onPressed: widget.book.availability
                  ? () {
                       Navigator.push(
                           context,
                        MaterialPageRoute(builder: (context) =>RequestPage (book: widget.book)),
                             );
                    }
                  : null,
              text: "Request this", // Disabled when false,
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}
