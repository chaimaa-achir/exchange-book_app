import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/widgets/Booksdispalyhome.dart';
import 'package:mini_project/theApp_screans.dart/widgets/catigory-display.dart';
//import 'package:http/http.dart';
//import 'dart:convert';
import 'package:mini_project/theApp_screans.dart/widgets/catigorybutton.dart';
import 'package:mini_project/theApp_screans.dart/widgets/searchbar.dart';
import 'package:mini_project/theApp_screans.dart/widgets/userdisplayhome.dart';



class Homesrean extends StatefulWidget {
  const Homesrean({super.key});

  @override
  State<Homesrean> createState() => _HomesreanState();
}

class _HomesreanState extends State<Homesrean> {
  List<String> allItems = [];

  Map recivedata = {};
   late SearchController _searchController = SearchController();
  @override
  void initState() {
    super.initState();
    //fetchUsers();
    
    _searchController = SearchController();
    
  }
    @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }



/*void fetchUsers() async {
   void fetchUsers() async {
  try {
    Response response = await get(Uri.parse('https://books-paradise.onrender.com/search/get-user/hanane'))
        .timeout(Duration(seconds: 5)); // Prevents freezing

    if (response.statusCode == 200) {
      var receivedData = jsonDecode(response.body);
      print(receivedData);
    } else {
      print("Error: Received ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("ERROR IS : $e");
  }
}

}*/

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
     final screenWidth =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFDFDFF),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.13,
          backgroundColor: Color.fromARGB(255, 230, 221, 255),
          elevation: 0,
          title: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1.050,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        " Welcome,FullName full namee ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width:screenWidth * 0.03,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1.050,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Colors.black54,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "tlemcen imama ",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ), // هذا المتغير يجب تحديده لاحقًا
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.007,
              ),
              FractionallySizedBox(
                widthFactor: 0.90,
                child: Text(
                  "Listings with 3.1m ",
                  style: TextStyle(color: Colors.black45, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.018,
                ),
                CustomSearchBar(
                  searchController: _searchController,
                  allItems: allItems,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: const Text(
                      "Categories",
                      style: TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    )),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Catigorydisplay(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const   Text(
                        "Most requested books",
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                          const  Text(
                              "All",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Bookdispalyhome(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const  Text(
                        "Books Near you",
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                          const  Text(
                              "All",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Bookdispalyhome(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const  Text(
                        "Top users",
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                          const  Text(
                              "All",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Userdisplayhome(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top books",
                        style: TextStyle(
                            color:Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                          const   Text(
                              "All",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Bookdispalyhome(),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
