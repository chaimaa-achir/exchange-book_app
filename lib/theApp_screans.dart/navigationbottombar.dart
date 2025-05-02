// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/screans/add-book.dart';
import 'package:mini_project/theApp_screans.dart/screans/add-forum.dart';
import 'package:mini_project/theApp_screans.dart/screans/community.dart';
import 'package:mini_project/theApp_screans.dart/screans/home.dart';
import 'package:mini_project/theApp_screans.dart/screans/meesagePage.dart';
import 'package:mini_project/theApp_screans.dart/screans/save.dart';

class Navigationbar extends StatefulWidget {
    final int initialIndex;
    
  const Navigationbar({super.key, this.initialIndex = 0});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
late int _selectedIndex;
late int _intPage;
  

  void _onItemTapped(int index) {
    setState(() {
      _intPage = index;
      _selectedIndex = index;
    });
  }
 @override
void initState() {
  super.initState();
  _selectedIndex = widget.initialIndex;
  _intPage = widget.initialIndex;
}
  
  @override
  Widget build(BuildContext context) {
      
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _intPage,
          children: [
            Homesrean(),
            savePage(),
            Container(),
            CommunityScreen(),
              MessagePage  (),
          ],
        ),

        extendBody:  true, // Ensures the floating button overlaps navigation bar correctly
        floatingActionButton: Container(
          height: screenHeight * 0.065,
          margin: const EdgeInsets.only(top: 20), // Adjust for proper placement
          child: FloatingActionButton(
            onPressed: () => _showBottomSheet(context),
            backgroundColor: Color(0xFFC4B5FD),
            shape: const CircleBorder(),
            elevation: 5,
            child: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          selectedItemColor: Color.fromARGB(255, 158, 107, 183),
          unselectedItemColor: Colors.grey,
          
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          items: [
            _buildNavItem(Icons.home_outlined, "Home", 0),
            _buildNavItem(Icons.bookmark_outline, "Saved", 1),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Empty space for FAB
              label: "",
            ),
            _buildNavItem(Icons.question_answer_outlined, "Community", 3),
            _buildNavItem(Icons.email_outlined, "Messages", 4),
          ],
          
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 30),
      label: label,
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(Icons.book, "Book",
                  "Share a book and spread knowledge ", Colors.purple),
              Divider(),
              _buildOption(Icons.forum, "Forum",
                  "Share topics with the community", Colors.orange),
              Divider(),
              Text(
                textAlign: TextAlign.center,
                "📤 Please choose what you want to post",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
      IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: () {
        if (title == "Book") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Addbookscrean()));
        } else if (title == "Forum") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddForumScreen()));
        }
      },
    );
  }
}
