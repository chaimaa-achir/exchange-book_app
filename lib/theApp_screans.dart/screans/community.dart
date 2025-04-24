import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_project/shared/notification-menu-icons.dart';
import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
import 'package:mini_project/theApp_screans.dart/widgets/cmmunitycard.dart';
import 'package:mini_project/theApp_screans.dart/widgets/drawer.dart';


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});
       
  @override
  Widget build(BuildContext context) {
    
  
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
        title: Text("Community "),
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
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" 📰 Posts",style: TextStyle(fontSize:26),),
            
            Divider(),
            Expanded(
              child: ListView.builder(
                    itemCount: communitylist.length,
                    itemBuilder: (context, index) {
                       return Communitycard(
                         community:communitylist[index],
                         );
                    }),
            )
          ],
        ),
      )
    );
  }
}
