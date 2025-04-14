import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/screans/chatscreen.dart';
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
          
          backgroundColor: Color.fromARGB(255, 230, 221, 255),
          
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
