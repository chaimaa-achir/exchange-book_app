// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_project/shared/notification-menu-icons.dart';
import 'package:mini_project/theApp_screans.dart/screans/chatscreen.dart';
import 'package:mini_project/theApp_screans.dart/widgets/drawer.dart';
import 'package:mini_project/theApp_screans.dart/widgets/searchbar.dart';

class MeesagePage extends StatefulWidget {
  const MeesagePage({super.key});

  @override
  State<MeesagePage> createState() => _MeesagePageState();
}

List<Map<String, String>> users = [
  {
    'username': 'Paulina',
    'image': 'assets/img/history.jpg',
  },
  {
    'username': 'Sophia',
    'image': 'assets/img/history.jpg',
  },
  {
    'username': 'Lina',
    'image': 'assets/img/history.jpg',
  },
];

class _MeesagePageState extends State<MeesagePage> {
  List<String> allItems = [];
  late SearchController _searchuser = SearchController();
  @override
  void initState() {
    super.initState();
    
    _searchuser = SearchController();
    
  }
    @override
  void dispose() {
    _searchuser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
  
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
        title: Text(
          "Messages",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomSearchBar(
                searchController: _searchuser,
                allItems: allItems,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Text(
              " 💭 All chats",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.start,
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                      username: user['username']!,
                                      userimage: user['image']!,
                                    )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(user['image']!),
                        ),
                        title: Text(user['username']!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "message here message message here message message here message message here message ",
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "7:50 pm",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
