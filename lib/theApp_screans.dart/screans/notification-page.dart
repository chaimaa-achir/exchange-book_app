// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse(
          'https://books-paradise.onrender.com/notifications/notifications/${10}'));
      print(" repose:${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // الآن نستخرج فقط الـ notifications من الكائن
        final List<dynamic> notificationList = jsonData['notifications'];

        setState(() {
          notifications = List<Map<String, dynamic>>.from(notificationList);

          isLoading = false;
        });
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> markAsRead(int index) async {
    int notificationId = notifications[index]["notifid"];
    try {
      final response = await http.put(
        Uri.parse(
            'https://books-paradise.onrender.com/notifications/read-notification/$notificationId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          notifications[index]["read"] = true;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Future<void> markAllAsRead() async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse('http://192.168.1.3:5000/notifications/1/read-all'),
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         for (var notification in notifications) {
  //           notification["lu"] = 1;
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Color.fromARGB(255, 230, 221, 255),
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : notifications.isEmpty
                ? Center(child: Text("No notifications available"))
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      var notification = notifications[index];
                      bool isRequest = notification["type"] == "book_request";
                      bool isRead = notification["read"];

                      return Card(
                        color: isRead
                            ? Color.fromARGB(255, 216, 206, 237)
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: Icon(
                                  isRead
                                      ? Icons.notifications_active
                                      : Icons.notifications_none,
                                  color: Color.fromARGB(255, 160, 107, 186),
                                ),
                                title: Text(
                                  "${notification["username"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 160, 107, 186),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(notification["message"]),
                                    SizedBox(height: 5),
                                    Text(
                                      formatDate(notification["created_at"]),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: isRead
                                    ? null
                                    : !isRequest
                                        ? IconButton(
                                            icon: Icon(Icons.check,
                                                color: Color.fromARGB(
                                                    255, 160, 107, 186)),
                                            onPressed: () {
                                              setState(() {
                                                notifications[index]["read"] =
                                                    true;
                                              });
                                            },
                                          )
                                        : null,
                              ),
                              if (isRequest && !isRead)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        
                                        setState(() {
                                          notifications[index]["read"] = true;
                                        });
                                      },
                                      child: Text("Accept",
                                          style:
                                              TextStyle(color: Colors.green)),
                                    ),
                                    SizedBox(width: 8),
                                    TextButton(
                                      onPressed: () {
                                        
                                        setState(() {
                                          notifications[index]["read"] = true;
                                        });
                                      },
                                      child: Text("Reject",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
  }
}
