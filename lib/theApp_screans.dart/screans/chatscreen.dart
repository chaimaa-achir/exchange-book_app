import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.userimage, required this.username});
  final String username;
  final String userimage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _controller = TextEditingController();
    ScrollController _scrollController = ScrollController();
  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        for (var file in pickedFiles) {
          messages.add({
            'image': File(file.path),
            'isMe': true,
            'timestamp': DateTime.now(),
          });
        }
      });
    }
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'text': text,
        "isMe": true,
        'timestamp': DateTime.now(),
      });
    });
    messages.add({
      'text': "This is a reply from other user.",
      "isMe": false,
      'timestamp': DateTime.now().add(Duration(seconds: 1)),
    });
    _controller.clear();
    _scrollToBottom();
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.userimage),
              radius: 20,
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(widget.username),
          ],
        ),
        elevation: 18,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                controller:  _scrollController,
                  reverse: true,
                  padding: EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - 1 - index];
                    final DateTime time = msg['timestamp'];
                    final formattedTime =
                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                    return Align(
                      alignment: msg['isMe']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: msg['isMe']
                              ? Color.fromARGB(255, 245, 229, 255)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (msg['image'] != null)
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.file(
                                  msg['image'],
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (msg['text'] != null) ...[
                              SizedBox(height: 4),
                              Text(msg['text']),
                            ],
                            SizedBox(
                                height:
                                    screenHeight * 0.003),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
          Divider(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                        focusColor: Color.fromARGB(255, 160, 107, 186),
                  ),
                )),
                IconButton(
                    onPressed: () => sendMessage(_controller.text),
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    )),
                IconButton(
                  icon: Icon(Icons.photo_outlined),
                  onPressed: _pickImages,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
