import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mini_project/theApp_screans.dart/screans/add.dart';
import 'package:mini_project/theApp_screans.dart/screans/home.dart';


class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _selectedIndex = 0;
  int _intPage = 0;
  final GlobalKey<CurvedNavigationBarState> _curvedNavigationKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
        _intPage = index;
    _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body:IndexedStack(
         children: [
           if(_intPage==0)
           Homesrean(),
          
           
         ],
       ),
        
        extendBody:
            true, // Ensures the floating button overlaps navigation bar correctly
        floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * 0.065,
          margin: const EdgeInsets.only(top: 20), // Adjust for proper placement
          child: FloatingActionButton(
            onPressed: () {
                Navigator.push(
                             context,
                          MaterialPageRoute(builder: (context) => Addbookscrean()),
                               );
            },
            backgroundColor: const Color.fromARGB(255, 230, 171, 255),
            shape: const CircleBorder(),
            elevation: 5,
            child: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CurvedNavigationBar(
          key: _curvedNavigationKey,
          index: _selectedIndex,
          height: 65,
          items: [
            _buildNavItem(Icons.home_outlined, "Home", 0),
            _buildNavItem(Icons.bookmark_outline, "Saved", 1),
            const SizedBox.shrink(), // Empty space for FAB
            _buildNavItem(Icons.question_answer_outlined, "Community", 3),
            _buildNavItem(Icons.email_outlined, "Messages", 4),
          ],
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          color: Color.fromARGB(255, 160, 107, 186),
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _intPage = index;
              
            });
          },
          letIndexChange:(index)=>true ,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 30,
              color: _selectedIndex == index ? Colors.black : Colors.black),
          Text(label,
              style: TextStyle(
                  fontSize: 9,
                  color:
                      _selectedIndex == index ? Colors.black : Colors.black)),
        ],
      ),
      
    );
    
  }
}
