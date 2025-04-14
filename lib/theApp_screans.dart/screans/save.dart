import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';
import 'package:mini_project/theApp_screans.dart/screans/book-details.dart';
import 'package:mini_project/theApp_screans.dart/widgets/bookcard-save.dart';
import 'package:provider/provider.dart';



List<Book> savedBooks = [];

class savePage extends StatefulWidget {
  const savePage({super.key});

  @override
  State<savePage> createState() => _savePageState();
}

class _savePageState extends State<savePage> {
  //final Book book;
  @override
  Widget build(BuildContext context) {
    final savedBooks = Provider.of<SavedBooksProvider>(context).savedBooks;
    return Scaffold(
      appBar: AppBar(
          actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined,
                  color: Colors.black, size: 28)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu,
                  color: Colors.black, size: 28)),
        ],
        title: Text("My Listing "),
        backgroundColor: Color.fromARGB(255, 230, 221, 255),
        
      ),
      body: ListView.builder(
          itemCount: savedBooks.length,
          itemBuilder: (context, index) {
            return Bookcard_save(
              ontapbook: (){
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetails (
                  book: books[index],
                  ),
                ),
              );
              },
              book: savedBooks[index]
            );
          }),
    );
  }
}
