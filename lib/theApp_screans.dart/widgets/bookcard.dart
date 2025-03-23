import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bookcard extends StatelessWidget {
  final Book book;
  final VoidCallback ontapbook;
  final VoidCallback ontapowner;
  const Bookcard(
      {Key? key,
      required this.book,
      required this.ontapbook,
      required this.ontapowner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        width:MediaQuery.of(context).size.width*0.4,
          margin: EdgeInsets.all(2),
         
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
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
              child: Image.asset(
                book.bookimage,
                height: MediaQuery.of(context).size.height*0.12,
                width:MediaQuery.of(context).size.width*0.4,
                fit: BoxFit.cover,
                ),
              borderRadius: BorderRadius.circular(12),
              ),
          ),
              Padding(
                padding:EdgeInsets.only(left:6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.booktitel),
                             // Rating Bar
                  RatingBarIndicator(
                    rating: book.rating,
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 12,
                    direction: Axis.horizontal,
                  ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
             Padding(
              padding: EdgeInsets.only(left:6),
               child: Row(
                children: [
                  GestureDetector(
                    onTap: ontapowner,
                    child: CircleAvatar(
                             radius:18,
                            backgroundImage: AssetImage(book.ownerimage),
                           ),
                  ),
                          SizedBox(
                           width: MediaQuery.of(context).size.width*0.01,
                          ),
                          Text(book.ownername, style: TextStyle(fontSize:10)),
                ],
               ),
             ),

                    ],
      ),
    ),
     Positioned(
      bottom: 100,
      right: 7,
      child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 64, 64, 64),
              borderRadius: BorderRadius.circular(8),
            ),
          child: Text(
              book.distence ,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 6,
              ),),
     ),
     ),
     Positioned(
      top: 2,
      left: 2,
      child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: book.bookstatus == "Exchange"
                  ? Colors.blue
                  : book.bookstatus == "Lending"
                      ? Colors.green
                      : book.bookstatus == "Sale"
                          ? Colors.orange
                          : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          child: Text(
              book.bookstatus,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 7,
              ),),
     ),
     )
      ],
    );
  }
}
