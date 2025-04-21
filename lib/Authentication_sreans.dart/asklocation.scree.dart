import 'package:flutter/material.dart';
import 'package:mini_project/Authentication_sreans.dart/currentlocation-page.dart';
import 'package:mini_project/shared/costumeelevatedBottom.dart';

class AsklocationsPage extends StatelessWidget {
  const AsklocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("👋",style: TextStyle(fontSize: 35),),
            Text("Hi,Username",style: TextStyle(fontSize:30),),
            Center(child: Text(" Before u can share your books , we need to know your location",style: TextStyle(fontSize:23),textAlign: TextAlign.center,)),
              SizedBox(
            height: MediaQuery.of(context).size.height*0.01
            ),
            RichText(
              textAlign: TextAlign.center,
              
              text: TextSpan(
              style: TextStyle(color: Colors.black ,fontSize: 15),
              children: [
                TextSpan(
                  text: "So we can show "
                ),
                TextSpan(
                  text: "nearby listing ",
                  style: TextStyle(color: Color.fromARGB(255, 160, 107, 186)),
                ),
                TextSpan(
                  text: ",& how many"
                ),
                TextSpan(
                  text: " other people",
                  style: TextStyle(color: Color.fromARGB(255, 160, 107, 186)),
                ),
                TextSpan(
                  text: " are waiting to share with u",
                ),
              ],
            )),
            SizedBox(
            height: MediaQuery.of(context).size.height*0.1
            ),
             myelvatedbottom(
              onPressed: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CurrentLocation()),
                          );
              },
              text: "Ok, let's go",
             ),
          ],
        ),
      ),
    );
  }
}
