import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/screans/book-details.dart';
import 'package:mini_project/theApp_screans.dart/widgets/bookcard.dart';


class Bookdispalyhome extends StatelessWidget {
  final List<Book> books;
  const Bookdispalyhome({super.key,required this.books});
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.24,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Bookcard(
              ontapbook: () {
                       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetails (
                  book: books[index],
                  ),
                ),
              );
              },
              ontapowner: () {},
              book: books[index],
            );
          }),
    );
  }
}
