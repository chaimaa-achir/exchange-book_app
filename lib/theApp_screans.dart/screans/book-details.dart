// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:mini_project/helpers/time_utils.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/screans/request-screen.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';
//import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

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
                  // print("the reason:$selectedReason");
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
              child: _isNetworkUrl(widget.book.bookimage)
                  ? CachedNetworkImage(
                      imageUrl: widget.book.bookimage,
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(
                      widget.book.bookimage,
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
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
                    icon: Icon(
                      savedBooksProvider.isSaved(widget.book)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      if (!savedBooksProvider.isSaved(widget.book)) {
                        savedBooksProvider.saveBook(widget.book);
                      }
                    },
                  ),
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
                          backgroundImage: widget.book.ownerimage != null
                              ? NetworkImage(widget.book.ownerimage!)
                              : AssetImage("assets/img/user.png")
                                  as ImageProvider,
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.book.ownername,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                widget.book.booktitel,
                                style: TextStyle(fontSize: 22),
                                textAlign: TextAlign.start,
                                maxLines: null,
                              ),
                              Text(
                                "By ${widget.book.author}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start,
                                maxLines: null,
                              ),
                              Text(
                                widget.book.postDate != null
                                    ? "added in ${timeAgo(widget.book.postDate!)}"
                                    : "No post date",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color.fromARGB(255, 74, 72, 72),
                                ),
                              )
                            ],
                          ),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            SizedBox(
              height: screenHeight * 0.29,
              width: screenWidth * 0.95,
              child: widget.book.latitude != null &&
                      widget.book.longitude != null
                  ? GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            widget.book.latitude!, widget.book.longitude!),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('book_location'),
                          position: LatLng(
                              widget.book.latitude!, widget.book.longitude!),
                          infoWindow: InfoWindow(title: widget.book.booktitel),
                        ),
                      },
                    )
                  : Center(
                      child: Text(
                        "No location available",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            myelvatedbottom(
              onPressed: widget.book.availability
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RequestPage(book: widget.book)),
                      );
                    }
                  : null,
              child: Text("Request this",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white)), // Disabled when false,
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
