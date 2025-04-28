// import 'package:flutter/material.dart';
// import 'package:mini_project/theApp_screans.dart/models/user.dart';
// import 'package:mini_project/theApp_screans.dart/widgets/usercard.dart';

// class Userdisplayhome extends StatefulWidget {
//   const Userdisplayhome({super.key});

//   @override
//   _UserdisplayhomeState createState() => _UserdisplayhomeState();
// }

// class _UserdisplayhomeState extends State<Userdisplayhome> {
//   List<User>? users;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadUsers();
//   }

//   Future<void> loadUsers() async {
//     users = await User.fetchTopUsers();
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     } else if (users == null || users!.isEmpty) {
//       return Center(child: Text('No users found'));
//     } else {
//       return SizedBox(
//         height: MediaQuery.of(context).size.height*0.12,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: users!.length,
//           itemBuilder: (context, index) {
//             return Usercard(
//               ontapUser: () {
              
//               },
//               user: users![index],
//             );
//           },
//         ),
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/user.dart';
import 'package:mini_project/theApp_screans.dart/widgets/usercard.dart';

class Userdisplayhome extends StatefulWidget {
  const Userdisplayhome({super.key});

  @override
  UserdisplayhomeState createState() => UserdisplayhomeState();
}

class UserdisplayhomeState extends State<Userdisplayhome> {
  List<User>? users;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    users = await User.fetchTopUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (users == null || users!.isEmpty) {
      return const Center(child: Text('No users found'));
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users!.length,
          itemBuilder: (context, index) {
            return Usercard(
              ontapUser: () {},
              user: users![index],
            );
          },
        ),
      );
    }
  }
}
