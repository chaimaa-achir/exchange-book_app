import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/screans/request-screen.dart';
import 'package:mini_project/theApp_screans.dart/widgets/currentlocation.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});
  //final Book book;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("book title"),
          elevation: 15,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.flag_outlined,
                  size: 30,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/img/history.jpg",
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.ios_share_outlined)),
                    Text(
                      "Share",
                      style: TextStyle(fontSize: 12),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
                    Text(
                      "Save",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("assets/img/history.jpg"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "username",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "Book title Book title ",
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "add in 26 minutens",
                                style: TextStyle(fontSize: 9,color: const Color.fromARGB(255, 74, 72, 72)),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                          "description of the book description of the book description of the bookdescription of the bookdescription of the book "),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      /*  if (widget.book.bookstatus == "Lending") ...[
                        Text(
                          "Duration lending ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "10 days",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                      ],
                  */
                   /*  if (widget.book.bookstatus == "Sale") ...[
                        Text(
                          "Book price ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "1000 DA",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                      ],
                  */
                      Text(
                        "Location",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width * 0.95,
                child: CurrentUserLocation(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                             context,
                          MaterialPageRoute(builder: (context) =>requestPAge ()),
                               );
                  },
                    style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      255, 160, 107, 186), // Button color
                                  padding: EdgeInsets.all(8), // Padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25), // Rounded corners
                                  ),
                                  elevation: 8, // Shadow effect
                                  shadowColor: Colors.deepPurple
                                      .withOpacity(0.9), // Shadow color
                                ),
                   child: Text("Request this",style:TextStyle(color: Colors.white,fontSize:17),),),
                   
              ),
                SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
            ],
          ),
        ),
      ),
    );
  }
}
