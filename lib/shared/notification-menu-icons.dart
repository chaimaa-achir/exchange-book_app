import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/screans/notification-page.dart';

class NotificationMenuIcons extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  const NotificationMenuIcons({
    Key? key,
    this.onMenuTap,
    this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
      
        Stack(
          children: [
            GestureDetector(
              onTap: onNotificationTap ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsPage()),
                    );
                  },
              child:const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 28,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "12",

                  /// get it form data base
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: screenWidth * 0.03),
        Builder(
          builder: (context) => InkWell(
            onTap: onMenuTap ??
                () {
                  Scaffold.of(context).openEndDrawer();
                },
            child: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
