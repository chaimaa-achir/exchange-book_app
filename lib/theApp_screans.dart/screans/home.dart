// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mini_project/helpers/getlocation.dart';
import 'package:mini_project/shared/notification-menu-icons.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:mini_project/theApp_screans.dart/widgets/Booksdispalyhome.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mini_project/theApp_screans.dart/widgets/drawer.dart';
import 'package:mini_project/theApp_screans.dart/widgets/searchbar.dart';
import 'package:mini_project/theApp_screans.dart/widgets/userdisplayhome.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homesrean extends StatefulWidget {
  const Homesrean({super.key});

  @override
  State<Homesrean> createState() => _HomesreanState();
}

class _HomesreanState extends State<Homesrean> {
  String? fullName;
  List<String> allItems = [];
  String? currentPlaceName;
  late Future<List<Book>> mostRequestedBooksFuture;
  late Future<List<Book>> booksNearYouFuture;

  Map recivedata = {};
  late SearchController _searchController = SearchController();
  @override
  void initState() {
    super.initState();
    //fetchUsers();
    loadCurrentUserLocationName();
    mostRequestedBooksFuture = fetchMostRequestedBooks();
    booksNearYouFuture = fetchBooksNearYou();
    loadUserName();

    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load the full name from SharedPreferences
  void loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('fullName'); // اسم المستخدم المحفوظ
    setState(() {
      fullName = name;
    });
  }

  Future<List<Book>> fetchMostRequestedBooks() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token');

      final latitude = prefs.getDouble('latitude');
      final longitude = prefs.getDouble('longitude');

      if (token == null || latitude == null || longitude == null) {
        print('⚠️ Missing token or location data.');
        return [];
      }

      // تجهيز الرابط
      final url = Uri.parse(
          'https://books-paradise.onrender.com/home/most-requested?userLat=$latitude&userLon=$longitude');

      // إرسال الطلب مع التوكين داخل الهيدر
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // هنا التوكين
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data received (Most Requested): $data');
        return (data as List).map((e) => Book.fromJson(e)).toList();
      } else {
        print('⚠️ Failed to fetch: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching most requested books: $e');
      return [];
    }
  }

  Future<List<Book>> fetchBooksNearYou() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final latitude = prefs.getDouble('latitude');
      final longitude = prefs.getDouble('longitude');

      if (token == null || latitude == null || longitude == null) {
        print('⚠️ Missing token or location data.');
        return [];
      }

      final url = Uri.parse(
          'https://books-paradise.onrender.com/home/near-you?userLat=$latitude&userLon=$longitude');

      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("body json off book near you$response.body");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data received (Most Requested): $data');
        return (data as List).map((e) => Book.fromJson(e)).toList();
      } else {
        print('⚠️ Error fetching books near you: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching books near you: $e');
      return [];
    }
  }

  void loadCurrentUserLocationName() async {
    final LatLng? savedLocation = await LocationStorage.getSavedLocation();
    if (savedLocation != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          savedLocation.latitude,
          savedLocation.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          setState(() {
            currentPlaceName = '${place.locality}, ${place.country}';
          });
        }
      } catch (e) {
        print('Error loading place name: $e');
        setState(() {
          currentPlaceName = 'Unknown location';
        });
      }
    } else {
      setState(() {
        currentPlaceName = 'Location not saved';
      });
    }
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
  Future<void> _refreshBooks() async {
  setState(() {
    mostRequestedBooksFuture = fetchMostRequestedBooks();
    booksNearYouFuture = fetchBooksNearYou();
  });
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: const CustomDrawer(),
      backgroundColor: Color(0xFFFDFDFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 0.05, right: screenWidth * 0.02),
            child: NotificationMenuIcons(),
          ),
        ],
        toolbarHeight: screenHeight * 0.13,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 1.050,
              child: Text(
                fullName != null ? "Welcome, $fullName" : "Loading...",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
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
                      currentPlaceName ?? 'Loading...',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ), // هذا المتغير يجب تحديده لاحقًا
                ],
              ),
            ),
            // SizedBox(
            //   height: screenHeight * 0.007,
            // ),
            // FractionallySizedBox(
            //   widthFactor: 0.90,
            //   child: Text(
            //     "Listings with 3.1m ",
            //     style: TextStyle(color: Colors.black45, fontSize: 10),
            //   ),
            // ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh:  _refreshBooks,
        child: SizedBox(
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
                // Catigorydisplay(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
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
                            const Text(
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

                // Bookdispalyhome(books: mostRequestedBooks),
                FutureBuilder<List<Book>>(
                  future: mostRequestedBooksFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading books'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No books found'));
                    } else {
                      return Bookdispalyhome(books: snapshot.data!);
                    }
                  },
                ),

                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: const Text(
                    "Top users",
                    style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Userdisplayhome(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: const Text(
                    "Books near you",
                    style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                FutureBuilder<List<Book>>(
                  future: booksNearYouFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading books'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No books found near you'));
                    } else {
                      return Bookdispalyhome(books: snapshot.data!);
                    }
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
