// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Bookcard extends StatelessWidget {
  final Book book;
  final VoidCallback ontapbook;
  final VoidCallback ontapowner;

  const Bookcard({
    super.key,
    required this.book,
    required this.ontapbook,
    required this.ontapowner,
  });

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool availability = book.availability;
    final statusColor = book.bookstatus == "Exchange"
        ? Colors.blue
        : book.bookstatus == "Lending"
            ? Colors.green
            : book.bookstatus == "Sale"
                ? Colors.orange
                : Colors.grey;

    Widget buildImage(String url) {
      if (_isNetworkUrl(url)) {
        return CachedNetworkImage(
          imageUrl: url,
          height: screenHeight * 0.12,
          width: screenWidth * 0.4,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      } else {
        return Image.asset(
          url,
          height: screenHeight * 0.12,
          width: screenWidth * 0.4,
          fit: BoxFit.cover,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.4,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 211, 209, 209),
                  offset: Offset(5, 7),
                  blurRadius: 10,
                ),
              ],
            ),
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
                        buildImage(book.bookimage),
                        if (!availability)
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Not Available",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(168, 255, 255, 255),
                                  ),
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
                        book.booktitel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ontapowner,
                        child: CircleAvatar(
                          backgroundImage: book.ownerimage != null
                              ? NetworkImage(book.ownerimage!)
                              : AssetImage("assets/img/user.png")
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: Text(
                          book.ownername,
                          style: const TextStyle(fontSize: 10),
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
          // Distance badge
          if (book.distence != null)
            Positioned(
              bottom: 78,
              right: 7.5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 64, 64, 64),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${book.distence!} km",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 6,
                  ),
                ),
              ),
            ),

          // Status badge
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
                book.bookstatus,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
