import 'package:flutter/material.dart';
import 'package:mini_project/helpers/communityapi.dart';
import 'package:mini_project/helpers/time_utils.dart';

import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
import 'package:mini_project/theApp_screans.dart/screans/postdetails.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Communitycard extends StatefulWidget {
  final Community community;
  const Communitycard({
    super.key,
    required this.community,
  });

  @override
  State<Communitycard> createState() => _CommunitycardState();
}

  Future<String?> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');
  if (userJson != null) {
    final userMap = jsonDecode(userJson);
    return userMap['username'];
  }
  return null;
}
class _CommunitycardState extends State<Communitycard> {
  String? currentuser;

  @override
  void initState() {
    super.initState();
    // Fetch username when widget initializes
    _loadUsername();
  }

  // Method to load username asynchronously
  Future<void> _loadUsername() async {
    final username = await getUsername();
    if (mounted) {
      setState(() {
        currentuser = username;
      });
    }
  }
  double getTextHeight(String text, TextStyle style, double width) {
    TextSpan textSpan = TextSpan(text: text, style: style);

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 7,
    )..layout(maxWidth: width);
    return textPainter.size.height;
  }
Future<void> _toggleLike() async {
  try {
    setState(() {
     widget.community.isLiked = !widget.community.isLiked;
      if ((widget.community.isLiked &&!widget.community.is_liked)||(!widget.community.isLiked && widget.community.is_liked) ) {
        widget.community.likes++;
      } else {
        widget.community.likes--;
      }
      
    });
    
    final response = await ApiService.toggleLike(widget.community.postId);
    
    if (response['success'] != true) {
      setState(() {
       widget.community.isLiked = !widget.community.isLiked;
      if ((!widget.community.isLiked &&!widget.community.is_liked)||(widget.community.isLiked && widget.community.is_liked) ){
        widget.community.likes++;
      } else {
        widget.community.likes--;
      }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? 'Failed to update like'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {

    setState(() {
      widget.community.isLiked=widget.community.isLiked;
      widget.community.likes=widget.community.likes;
      });
    
    print('Error toggling like: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error updating like'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context)  {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
   
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(0.02),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      

                      builder: (context) => Postdetails(
                      postId: widget.community.postId,isLiked: widget.community.is_liked,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: widget.community.userimage.startsWith('http')
                                  ? NetworkImage(widget.community.userimage)
                                  : const AssetImage('assets/img/user.png') as ImageProvider,
                              radius: 20,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.community.username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    timeAgo(widget.community.createdAt),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) async {
                               if (value == 'delete') {
                                  
                                   showDeleteConfirmationDialog(context,
                                     widget.community.postId
                                  );
                                }
                                else if(value=='report'){
                                     showReportOptions(context,(reason) {
                                            _reportPost(context,widget.community.postId, reason);
                                    });
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<String>(
                                  value: 'report',
                                  child: Row(
                                    children: [
                                      Icon(Icons.flag, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Report'),
                                  
                                    ],
                                    
                                  ),
                                ),
                               
                                if(currentuser==widget.community.username)
                                 PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                  
                                    ],
                                    
                                  ),
                                ),
                                
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Post content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          widget.community.content,
                          style: TextStyle(fontSize: 16),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8),
                      if (widget.community.mediaUrls.isNotEmpty)
                        _buildMediaContent(widget.community.mediaUrls),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                ((!widget.community.isLiked && widget.community.is_liked)||(widget.community.isLiked && !widget.community.is_liked)) ? Icons.favorite : Icons.favorite_border,
                                color: ((!widget.community.isLiked && widget.community.is_liked)||(widget.community.isLiked && !widget.community.is_liked)) ? Colors.red : Colors.grey,
                              ),
                              onPressed: _toggleLike,
                            ),
                            Text(
                              '${widget.community.likes}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 16),
                            IconButton(
                              icon: Icon(Icons.comment_outlined, color: Colors.grey),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Postdetails(
                                    postId: widget.community.postId,isLiked:widget.community.is_liked
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              '${widget.community.commentsCount}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.share_outlined, color: Colors.grey),
                              onPressed: () {
                    
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMediaContent(List<String> mediaUrls) {
  if (mediaUrls.isEmpty) return SizedBox.shrink();
  
  if (mediaUrls.length == 1) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          mediaUrls[0],
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey[500]),
              ),
            ),
        ),
      ),
    );
  }

  else {
    int currentPage = 0;
    
    return StatefulBuilder(
      builder: (context, setInnerState) {
        return Column(
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: mediaUrls.length,
                controller: PageController(),
                onPageChanged: (int page) {
                  setInnerState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        mediaUrls[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(Icons.broken_image, size: 50, color: Colors.grey[500]),
                            ),
                          ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                mediaUrls.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? const Color.fromARGB(255, 205, 33, 243) : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}}
void showDeleteConfirmationDialog(BuildContext context, String postId) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Confirm Delete"),
        content: Text("Do you want to delete this post?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
            },
          ),
          TextButton(
            child: Text("OK", style: TextStyle(color: Colors.red)),
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Close dialog first
              await deletepost(context, postId); // Call your delete function
            },
          ),
        ],
      );
    },
  );
}

Future<void> deletepost(BuildContext context,String postId) async {

  try{
    final response =await ApiService.deletepost(
      postId
    );
    if(response['success']==true){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),);
    }
  }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
}
Future<void> _reportPost(BuildContext context,String postId,String reason) async {

  try{
    final response =await ApiService.reportitem(
      postId,reason,'post'
    );
    if(response['success']==true){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),);
    }
  }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
}
