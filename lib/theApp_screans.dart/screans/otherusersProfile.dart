// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({super.key});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  String aboutUser = "";
  List<Map<String, dynamic>> userBooks = [];

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    await Future.delayed(Duration(seconds: 1));
    String fetchedBio = "👋 I love collecting and exchanging books!";
    List<Map<String, dynamic>> fetchedBooks = [
      {
        "booktitel": "Rich Dad Poor Dad",
        "bookstatus": "Exchange",
        "ownername": "Sara",
        "ownerimage": "assets/img/history.jpg",
        "distence": "3.1 km",
        "bookimage": "assets/img/history.jpg",
        "availability": true,
      },
      {
        "booktitel": "Deep Work",
        "bookstatus": "Lending",
        "ownername": "Sara",
        "ownerimage": "assets/img/history.jpg",
        "distence": "2.0 km",
        "bookimage": "assets/img/history.jpg",
        "availability": false,
      },
    ];

    setState(() {
      aboutUser = fetchedBio;
      userBooks = fetchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Username'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
          child: Column(
            children: [
              // الصورة + المتابعين
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 39,
                    backgroundImage: AssetImage("assets/img/history.jpg"),
                  ),
                  Column(
                    children: const [
                      Text("120", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Followers"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("80", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("About username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: screenHeight * 0.01),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  aboutUser.isNotEmpty ? aboutUser : "No bio added yet...",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("📚 Books Posted", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
    
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userBooks.length,
                itemBuilder: (context, index) {
                  final book = userBooks[index];
    
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 110, 109, 109),
                                offset: Offset(5, 7),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle book tap
                                },
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
                                        child: Image.asset(
                                          book["bookimage"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (!book["availability"]) // Apply blur only if book is unavailable
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: book["bookstatus"] == "Exchange"
                                            ? Colors.blue
                                            : book["bookstatus"] == "Lending"
                                                ? Colors.green
                                                : book["bookstatus"] == "Sale"
                                                    ? Colors.orange
                                                    : Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        book["bookstatus"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 7,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      book["booktitel"],
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: screenHeight * 0.001),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundImage: AssetImage(book["ownerimage"]),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Text(
                                          book["ownername"],
                                          style: TextStyle(fontSize: 10),
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
                                          book["distence"],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
