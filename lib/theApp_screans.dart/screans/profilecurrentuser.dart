import 'package:flutter/material.dart';
import 'dart:ui';

class ProfilecurrentUser extends StatefulWidget {
  const ProfilecurrentUser({super.key});

  @override
  State<ProfilecurrentUser> createState() => _ProfilecurrentUserState();
}

List<Map<String, dynamic>> dummyBooks = [
  {
    "booktitel": "The Alchemist",
    "bookstatus": "Exchange",
    "ownername": "Ali",
    "ownerimage": "assets/img/history.jpg",
    "rating": 4.6,
    "distence": "2.3 km",
    "bookimage": "assets/img/history.jpg",
    "availability": true,
  },
  {
    "booktitel": "Atomic Habits",
    "bookstatus": "Lending",
    "ownername": "Lina",
    "ownerimage": "assets/img/history.jpg",
    "rating": 4.8,
    "distence": "5.1 km",
    "bookimage": "assets/img/history.jpg",
    "availability": false,
  },
  {
    "booktitel": "1984",
    "bookstatus": "Sale",
    "ownername": "Mohammed",
    "ownerimage": "assets/img/history.jpg",
    "rating": 4.2,
    "distence": "1.8 km",
    "bookimage": "assets/img/history.jpg",
    "availability": true,
  },
];

String? aboutUser = "";
bool avibility = true;

class _ProfilecurrentUserState extends State<ProfilecurrentUser> {
  final bool isCurrentUser = true; // لتحديد إذا كان المستخدم الحالي أم لا

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
            child: Column(
              children: [
                // Top profile info (image + followers)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 39,
                          backgroundImage: AssetImage("assets/img/history.jpg"),
                        ),
                        Positioned(
                          bottom: screenHeight * -0.01,
                          right: screenWidth * -0.03,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(0, 255, 255, 255),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, size: 30, color: Colors.grey),
                              onPressed: () {
                                // Edit profile image
                              },
                            ),
                          ),
                        ),
                      ],
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

                // About user edit button or follow button for other users
                isCurrentUser
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          final newBio = await showDialog<String>(
                            context: context,
                            builder: (context) => _buildEditBioDialog(context, aboutUser ?? ""),
                          );

                          if (newBio != null) {
                            setState(() {
                              aboutUser = newBio;
                            });
                          }
                        },
                        icon: Icon(Icons.edit_note, color: Colors.white),
                        label: Text("Edit About", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 182, 166, 247), // لون الزر
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                          elevation: 4,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          // Follow action
                        },
                        icon: Icon(Icons.person_add, color: Colors.white),
                        label: Text("Follow", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 182, 166, 247),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                          elevation: 4,
                        ),
                      ),
                SizedBox(height: screenHeight * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "About you",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    (aboutUser != null && aboutUser!.isNotEmpty)
                        ? aboutUser!
                        : "No bio added yet...",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    textAlign: TextAlign.start,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Example: User's posted books
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "📚 Books Posted",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                // Dummy list of books
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dummyBooks.length,
                  itemBuilder: (context, index) {
                    final book = dummyBooks[index];

                    return Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
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
                                      // Here, you can navigate to book details or perform actions based on the user's role.
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
                                          if (!book["availability"])
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
                                        Column(
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
                                            if (!isCurrentUser) // للمستخدمين الآخرين
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
                                                  SizedBox(width: screenWidth * 0.01),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    book["rating"].toString(),
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                        if (!isCurrentUser) // للمستخدمين الآخرين
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Write something about yourself...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // cancel
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.pop(context, _controller.text.trim()), // save
          child: Text("Save"),
        ),
      ],
    );
  }
}
