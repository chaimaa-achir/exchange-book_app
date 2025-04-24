import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileCurrentUserScreen extends StatefulWidget {
  const ProfileCurrentUserScreen({super.key});

  @override
  State<ProfileCurrentUserScreen> createState() =>
      _ProfileCurrentUserScreenState();
}

class _ProfileCurrentUserScreenState extends State<ProfileCurrentUserScreen> {
  String aboutUser = "";
  File? _profileImage;
  List<Map<String, dynamic>> userBooks = [];

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> pickImageForProfile() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> fetchProfileData() async {
    await Future.delayed(Duration(seconds: 1));

    String fetchedBio = "📚 Hii, I love reading and books!";
    List<Map<String, dynamic>> fetchedBooks = [
      {
        "booktitel": "The Alchemist",
        "bookstatus": "Exchange",
        "bookimage": "assets/img/history.jpg",
        "availability": true,
      },
      {
        "booktitel": "Atomic Habits",
        "bookstatus": "Lending",
        "bookimage": "assets/img/history.jpg",
        "availability": false,
      },
      {
        "booktitel": "1984",
        "bookstatus": "Sale",
        "bookimage": "assets/img/history.jpg",
        "availability": true,
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
      appBar: AppBar(title: Text("UserName")),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage("assets/img/user.png")
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: screenHeight * -0.015,
                      right: screenWidth * -0.02,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey, size: 30),
                        onPressed: pickImageForProfile,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text("120",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Followers"),
                  ],
                ),
                Column(
                  children: const [
                    Text("80",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Following"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newBio = await showDialog<String>(
                    context: context,
                    builder: (_) => _buildEditBioDialog(context, aboutUser),
                  );
                  if (newBio != null) {
                    setState(() => aboutUser = newBio);
                  }
                },
                icon: Icon(Icons.edit_note, color: Colors.white),
                label:
                    Text("Edit About", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 182, 166, 247),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.015),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("About you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              aboutUser.isNotEmpty ? aboutUser : "No bio added yet...",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            Text("📚 Books Posted",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userBooks.length,
              itemBuilder: (context, index) {
                final book = userBooks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                book["bookimage"],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              if (!book["availability"])
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.3),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Not Available",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color:
                                        _getStatusColor(book["bookstatus"]),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    book["bookstatus"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  book["booktitel"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditBioDialog(BuildContext context, String currentBio) {
    TextEditingController _controller = TextEditingController(text: currentBio);
    return AlertDialog(
      title: Text("Edit Bio"),
      content: TextField(
        controller: _controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: "Write something about yourself...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, _controller.text.trim()),
            child: Text("Save")),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Exchange":
        return Colors.blue;
      case "Lending":
        return Colors.green;
      case "Sale":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
