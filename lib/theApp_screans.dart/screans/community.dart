import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
import 'package:mini_project/theApp_screans.dart/widgets/cmmunitycard.dart';


class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});
       
  @override
  Widget build(BuildContext context) {
    
     print("Community List: $communitylist");
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
        title: Text("Community "),
        backgroundColor: Color.fromARGB(255, 230, 221, 255),
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
