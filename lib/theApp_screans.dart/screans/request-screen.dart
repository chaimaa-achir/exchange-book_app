// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RequestPage extends StatefulWidget {
  final Book book;
  const RequestPage({super.key, required this.book});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

Book? selectedBookForExchange;

class _RequestPageState extends State<RequestPage> {
  bool _isNetworkUrl(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 18,
        title: const Text("Make Request"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Book owner section
              /// /// Book owner section (book image + title + owner)
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _isNetworkUrl(widget.book.bookimage)
                        ? CachedNetworkImage(
                            imageUrl: widget.book.bookimage,
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.04,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            widget.book.bookimage,
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.04,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.book.booktitel,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: widget.book.ownerimage != null
                        ? NetworkImage(widget.book.ownerimage!)
                        : AssetImage("assets/img/user.png")
                            as ImageProvider,
                  ),
                  const SizedBox(width: 10),
                  Text(
                     widget.book.ownername
                  ),
                ],
              ),
              if (widget.book.bookstatus == "Lending") ...[
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: const Text(
                    "How many days would you like to borrow this book?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter number of days",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
              ],
              if (widget.book.bookstatus == "Exchange") ...[
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: const Text(
                    "Select a book you want to offer in exchange:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Button color
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.07), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Rounded corners
                    ),
                    elevation: 8, // Shadow effect
                    // Shadow color
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SelectExchangeBookPage(), // صفحة اختيار الكتاب
                      ),
                    );
                    if (result != null && result is Book) {
                      setState(() {
                        selectedBookForExchange = result;
                      });
                    }
                  },
                  child: Text(
                    selectedBookForExchange == null
                        ? "Choose a book"
                        : "Selected: ${selectedBookForExchange!.booktitel}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              const SizedBox(
                height: 20,
              ),

              /// Message input
              FractionallySizedBox(
                widthFactor: 1,
                child: const Text(
                  "Add a message to your request",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Send a friendly message to chaimaa",
                  //  "Send a friendly message to ${widget.book.ownername}",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const UnderlineInputBorder(),
                ),
                maxLines: 2,
              ),

              SizedBox(
                height: screenHeight * 0.2,
              ),

              /// Send button
              myelvatedbottom(
                  onPressed: () {},
                  child: Text("Send request",
                      style: TextStyle(fontSize: 18, color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectExchangeBookPage extends StatelessWidget {
  // هذا المفروض يكون من API: كتب المستخدم اللي حالتها Exchange
  final List<Book> userExchangeBooks = [
    Book(
        ownerid: 1,
        bookid: 1,
        booktitel: "My Book 1",
        bookimage: "assets/img/history.jpg",
        bookstatus: "Exchange",
        ownername: '',
        ownerimage: '',
        // ownername: "",
        // ownerimage: "",
        distence: null,
        postDate: DateTime(2025, 3, 25, 14, 30),
        availability: true,
        category: "",
        author: ""),
    Book(
      ownerid: 1,
      bookid: 1,
      booktitel: "My Book 2",
      bookimage: "assets/img/history.jpg",
      bookstatus: "Exchange",
      author: "",
      ownername: '',
      ownerimage: '',
      // ownername: "",
      // ownerimage: "",
      distence: null,
      postDate: DateTime(2025, 3, 25, 14, 30),
      availability: true,
      category: "",
    ),
  ];

  SelectExchangeBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Book")),
      body: ListView.builder(
        itemCount: userExchangeBooks.length,
        itemBuilder: (context, index) {
          final book = userExchangeBooks[index];
          return ListTile(
            leading: Image.asset(book.bookimage,
                width: MediaQuery.of(context).size.width * 0.15),
            title: Text(book.booktitel),
            onTap: () {
              Navigator.pop(context, book); // نرجع الكتاب المختار
            },
          );
        },
      ),
    );
  }
}
