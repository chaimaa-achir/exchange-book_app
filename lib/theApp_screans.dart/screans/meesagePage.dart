import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:intl/intl.dart'; // Add this for better date formatting
import 'chatscreen.dart';
import 'package:mini_project/shared/notification-menu-icons.dart';
import 'package:mini_project/theApp_screans.dart/widgets/drawer.dart';
import 'package:mini_project/theApp_screans.dart/widgets/searchbar.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<String> allItems = [];
  late SearchController _searchuser = SearchController();
  bool isLoading = true;
  
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  
  @override
  void dispose() {
    _searchuser.dispose();
    super.dispose();
  }
  
  List<Map<String, dynamic>> conversations = [];
  int? currentUserId;
  
  Future<void> fetchConversations() async {
    setState(() {
      isLoading = true;
    });
    
    final token = await getToken();
   
    if (token == null) {
      print('No JWT token found!');
      setState(() {
        isLoading = false;
      });
      return;
    }
    
    Future<int?> getUserId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson != null) {
        final userMap = jsonDecode(userJson);
        return userMap['userId'];
      }
      return null;
    }
    
    currentUserId = await getUserId();
    print(currentUserId);

    try {
      final response = await http.get(
        Uri.parse('https://books-paradise.onrender.com/chat/get-conversations'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is List) {
          setState(() {
            conversations = decoded.map<Map<String, dynamic>>((conversation) {
              print("${conversation['messageid']}");
              return {
                
                'conversationid': conversation['conversationid'],
                'user1_id': conversation['user1_id'],
                'user2_id': conversation['user2_id'],
                'user1_name': conversation['user1_name'],
                'user2_name': conversation['user2_name'],
                'user2_profile_pic': conversation['user2_profile_pic'] ?? '',
                'messageid':conversation['messageid'],
                'last_message': conversation['last_message'],
                'last_message_time': conversation['last_message_time'],
                'is_read': conversation['last_message_is_read'],
                'senderid':conversation['last_message_sender'],
                
              };
            }).toList();
            isLoading = false;
          });
        }
      } else {
        print('Failed to load conversations');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching conversations: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  
  Future<void> markConversationAsRead(String messageId) async {
    final token = await getToken();

    if (token == null) return;

    final response = await http.patch(
      Uri.parse('https://books-paradise.onrender.com/chat/mark-as-read/$messageId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
     // body: json.encode({'is_read': true}),
    );

    if (response.statusCode == 200) {
      print('Conversation marked as read');
      // Update the local state to reflect the change
      
    } else {
      print('Failed to mark conversation as read');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchConversations();
    _searchuser = SearchController();
  }

  Future<void> _refreshConversations() async {
    await fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: NotificationMenuIcons(),
          ),
        ],
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshConversations,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomSearchBar(
                  searchController: _searchuser,
                  allItems: allItems,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      '💭 All chats',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 1.5),
              isLoading
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8EC5FC)),
                        ),
                      ),
                    )
                  : conversations.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text(
                              'No conversations yet',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: conversations.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 0.5,
                              indent: 70,
                            ),
                            itemBuilder: (context, index) {
                              final convo = conversations[index];
                              final bool isCurrentUserUser1 = currentUserId == convo['user1_id'];
                              final String displayName = isCurrentUserUser1 ? convo['user2_name'] : convo['user1_name'];
                              final String? profilePic = convo['user2_profile_pic'] ??'assets/img/user.png';
                              final String userProfilePic = profilePic != null && profilePic.isNotEmpty
                                  ? profilePic
                                  : 'assets/img/user.png';
                              final bool isRead = convo['is_read'];
                              final int senderid=convo['senderid'];
                             // final String messageid=convo['messageid'];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                  color: isRead ? Colors.transparent : Color(0xFFE0C3FC).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () async {
                                   // print("$messageid");
                                    await markConversationAsRead(convo['messageid'].toString());
                                    final String conversationIdStr = convo['conversationid'].toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          conversationId: conversationIdStr,
                                          username: displayName,
                                          userimage: userProfilePic,
                                        ),
                                      ),
                                    ).then((_) => fetchConversations());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ListTile(
                                      leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xFF8EC5FC),
                                            width: 2,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(userProfilePic),
                                          onBackgroundImageError: (_, __) => const AssetImage('assets/img/user.png'),
                                        ),
                                      ),
                                      title: Text(
                                        displayName,
                                        style: TextStyle(
                                          fontWeight:(isRead || (currentUserId==senderid)) ? FontWeight.normal : FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          convo['last_message'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: (isRead || (currentUserId==senderid)) ? Colors.grey : Colors.black87,
                                            fontWeight: (isRead || (currentUserId==senderid)) ? FontWeight.normal : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            _formatTime(convo['last_message_time']),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: (isRead || (currentUserId==senderid)) ? Colors.grey : Color(0xFF8EC5FC),
                                              fontWeight: (isRead ||(currentUserId==senderid)) ? FontWeight.normal : FontWeight.bold,
                                            ),
                                          ),
                                          if (!isRead &&(currentUserId!=senderid))
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF8EC5FC),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String timestamp) {
    final DateTime dateTime = DateTime.parse(timestamp).toLocal();
    final DateTime now = DateTime.now();

    if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } 

    else if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day - 1) {
      return 'Yesterday';
    } 
    else if (now.difference(dateTime).inDays < 7) {
      switch (dateTime.weekday) {
        case 1: return 'Mon';
        case 2: return 'Tue';
        case 3: return 'Wed';
        case 4: return 'Thu';
        case 5: return 'Fri';
        case 6: return 'Sat';
        case 7: return 'Sun';
        default: return '';
      }
    } 
    else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }
}