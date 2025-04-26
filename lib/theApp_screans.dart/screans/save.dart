// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mini_project/shared/notification-menu-icons.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';
import 'package:mini_project/theApp_screans.dart/screans/book-details.dart';
import 'package:mini_project/theApp_screans.dart/widgets/bookcard-save.dart';
import 'package:mini_project/theApp_screans.dart/widgets/drawer.dart';
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
        endDrawer: const CustomDrawer(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10),
              child: NotificationMenuIcons(),
            ),
        ],
        title: Text("My Listing "),
        backgroundColor: Colors.transparent,
         flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
