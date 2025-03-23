import 'package:flutter/material.dart';
import 'package:mini_project/Cashdatasave/cashhelper.dart';
import 'package:mini_project/theApp_screans.dart/widgets/Booksdispalyhome.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mini_project/theApp_screans.dart/widgets/catigorybutton.dart';
import 'package:mini_project/theApp_screans.dart/widgets/searchbar.dart';

class Homesrean extends StatefulWidget {
  const Homesrean({super.key});

  @override
  State<Homesrean> createState() => _HomesreanState();
}

class _HomesreanState extends State<Homesrean> {
  List<String> allItems = [];

  Map recivedata = {};
  final SearchController _searchController = SearchController();
  String fullname = "guste";
  @override
  void initState() {
    super.initState();
    fetchUsers();
    getFullname();
    
  }

  Future<void> getFullname() async {
    await CacheData.cacheInitialisations();
    String fullName = await CacheData.getData(key: "fullname");
    setState(() {
      fullname = fullName;
    });
  }

void fetchUsers() async {
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

}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.13,
          backgroundColor: Color.fromARGB(255, 255, 221, 230),
          elevation: 0,
          title: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1.050,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " Welcome,$fullname ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
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
                          width: MediaQuery.of(context).size.width * 0.03,
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
                height: MediaQuery.of(context).size.height * 0.007,
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
                  height: MediaQuery.of(context).size.height * 0.018,
                ),
                CustomSearchBar(
                  searchController: _searchController,
                  allItems: allItems,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Catigorybutton(
                          title: "history",
                          ontap: () {},
                        ),
                        Catigorybutton(
                          title: "history",
                          ontap: () {},
                        ),
                        Catigorybutton(
                          title: "history",
                          ontap: () {},
                        ),
                        Catigorybutton(
                          title: "history",
                          ontap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most requested books",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
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
                      Text(
                        "Books Near you",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
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
                      Text(
                        "Top books",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
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
                      Text(
                        "Top users",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
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
