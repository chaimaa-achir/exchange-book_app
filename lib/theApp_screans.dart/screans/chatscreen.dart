import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  
  const ChatScreen({
    super.key,
    required this.userimage,
    required this.username,
    required this.conversationId,
  });

  final String username; 
  final String userimage; 
  final String conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
  
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  //final token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjEwLCJpYXQiOjE3NDU2MDU1OTQsImV4cCI6MTc0NTY5MTk5NH0.vOXx6hqLjfx2yEWM-UdDNjD48wR-u7PBTuU8rUrliWw';
   Future<String?>getToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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

   // Replace with your logged-in user ID

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

void _scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scrollController.hasClients) {
      // For reversed ListView (chat UI), scroll to 0 instead of maxScrollExtent
      _scrollController.animateTo(
        0, // This is correct when reverse: true
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });
}

Future<void> _fetchMessages() async {
  final response = await http.get(
    Uri.parse('https://books-paradise.onrender.com/chat/get-messages/${widget.conversationId}'),
  );
  final currentUserId = await getUserId();
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      messages = data.expand((msg) {
        final List<dynamic> urls = msg['media_url'] ?? [];
        print('currentUserId: $currentUserId');
    print('senderid: ${msg['senderid']}');
        if (urls.isEmpty) {
          return [
            {
              'text': msg['message_text'],
              'image': null,
              'isMe': msg['senderid'] == currentUserId,
              'timestamp': DateTime.parse(msg['created_at']),
            }
          ];
          
        } else {
          return urls.map((url) => {
                'text': msg['message_text'] != '' ? msg['message_text'] : null,
                'image': url,
                'isMe': msg['senderid'] == currentUserId,
                'timestamp': DateTime.parse(msg['created_at']),
              });
        }
      }).toList();
    });
  } else {
    print('Failed to fetch messages: ${response.statusCode}');
  }
}


Future<void> sendMessage(String text) async {
  if (text.trim().isEmpty) return;
  final token = await getToken();
  final body = json.encode({
    'conversation_id': widget.conversationId,
    'message_type': 'Text',
    'message_text': text,
   
  });

  final response = await http.post(
    Uri.parse('https://books-paradise.onrender.com/chat/send-message'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: body,
  );

  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    if (data['success']) {
      setState(() {
        messages.add({
          'text': text,
          'image': null,
          'isMe': true,
          'timestamp': DateTime.now(),
        });
      });
      _controller.clear();
      _scrollToBottom();
    }
  } else {
    print('Error sending message: ${response.statusCode}');
  }
}

Future<void> _pickImages() async {
  final pickedFiles = await ImagePicker().pickMultiImage();
  final token = await getToken();
  if ( pickedFiles.isNotEmpty) {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://books-paradise.onrender.com/chat/send-message'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['conversation_id'] = widget.conversationId;
    request.fields['message_type'] = 'Image';
    request.fields['message_text'] = ''; 

    // Add the images to the request
    for (var file in pickedFiles) {
       request.files.add(
        await http.MultipartFile.fromPath('images', file.path));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      final respStr = await response.stream.bytesToString();
      final data = json.decode(respStr);

      if (data['success']) {
        final List<String> imageUrls = List<String>.from(data['message']['media_url'] ?? []);
        setState(() {
          for (var url in imageUrls) {
            messages.add({
              'text': null,
              'image': url,
              'isMe': true,
              'timestamp': DateTime.now(),
            });
          }
        });
        _scrollToBottom();
      }
    } else {
      print('Failed to send image: ${response.statusCode}');
    }
  }
}





  @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Color(0xFFE0C3FC), // Changed to first gradient color
      leading: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: widget.userimage.startsWith('http')
                                  ? NetworkImage(widget.userimage)
                                  : const AssetImage('assets/img/user.png') as ImageProvider,
         
        ),
      ),
      title: Text(
        widget.username,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black, // Added for better contrast
        ),
      ),
      // Removed call and video call buttons
    ),
    body: Container(
      decoration: BoxDecoration(
        // Kept original background
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [Colors.grey[900]!, Colors.black]
              : [Colors.grey[100]!, Colors.white],
        ),
      ),
      child: Column(
        children: [
          // Date separator bubble
          
          
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                final DateTime time = msg['timestamp'];
                final formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                final bool isMe = msg['isMe'];
                
                // Show sender avatar for received messages
                final Widget avatar = isMe
                    ? const SizedBox(width: 32)
                    : CircleAvatar(
                        backgroundImage: widget.userimage.startsWith('http')
                                  ? NetworkImage(widget.userimage)
                                  : const AssetImage('assets/img/user.png') as ImageProvider,
                        radius: 16,
                      );
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) avatar,
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMe 
                                ? Color(0xFFE0C3FC) // Changed to first gradient color
                                : theme.cardColor, // Kept original for !isme messages
                            borderRadius: BorderRadius.circular(20).copyWith(
                              bottomRight: isMe ? const Radius.circular(4) : null,
                              bottomLeft: !isMe ? const Radius.circular(4) : null,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (msg['image'] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: Image.network(
                                      msg['image'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          height: 180,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                
                              if (msg['text'] != null)
                                Text(
                                  msg['text'] ?? '',
                                  style: TextStyle(
                                    color: isMe
                                        ? Colors.black // Changed for better contrast
                                        : theme.textTheme.bodyLarge?.color,
                                    fontSize: 16,
                                  ),
                                ),
                                
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isMe
                                          ? Colors.black.withOpacity(0.7) // Changed for better contrast
                                          : theme.textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    //  if (isMe) const SizedBox(width: 32),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Message composer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -1),
                  blurRadius: 5,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
            
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              maxLines: 5,
                              minLines: 1,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.image), // Changed from attach_file to image
                            color: Color.fromARGB(255, 0, 0, 0), // Changed to second gradient color
                            onPressed: () {
                              // Show attachment options
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.photo, color: Color.fromARGB(255, 243, 142, 252)),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImages();
                                      },
                                    ),
                                   
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0C3FC), // Changed to first gradient color
                    ),
                    child: IconButton(
                      onPressed: () => sendMessage(_controller.text),
                      icon: const Icon(Icons.send, color: Colors.black), // Changed to black for contrast
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}