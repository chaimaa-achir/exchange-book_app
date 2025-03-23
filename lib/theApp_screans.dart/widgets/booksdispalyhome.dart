import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/widgets/bookcard.dart';


class Bookdispalyhome extends StatelessWidget {
  Bookdispalyhome({super.key});
  final List<Book> books = [
    Book(
      booktitel: "harry potter",
      ownername: "chaima_moonlight",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus: "Borrow",
      distence: "3.8km",
      rating: 9,
    ),
    Book(
      booktitel: "evil under the sun",
      ownername: "hadji_asheer",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus:"Exchange",
      distence: "12m",
      rating: 7,
    ),
      Book(
      booktitel: "فجر اسلام ",
      ownername: "halloula20",
      bookimage: "assets/img/history.jpg",
      ownerimage: "assets/img/history.jpg",
      bookstatus:"Sale",
      distence: "5.9km",
      rating: 7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.26,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Bookcard(
              ontapbook: () {},
              ontapowner: () {},
              book: books[index],
            );
          }),
    );
  }
}
