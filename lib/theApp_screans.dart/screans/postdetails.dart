import 'package:flutter/material.dart';
import 'package:mini_project/helpers/comment_utils.dart';
import 'package:mini_project/helpers/communityapi.dart';
import 'package:mini_project/helpers/time_utils.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Postdetails extends StatefulWidget {
  const Postdetails({super.key, required this.postId, required this.isLiked});
  final String postId;
  final bool isLiked;
  
  @override
  State<Postdetails> createState() => _PostdetailsState();
}

class CurrentUser {
  final String id;
  final String name;
  final String profilePic;
  
  CurrentUser({
    required this.id,
    required this.name,
    required this.profilePic,
  });
}

class _PostdetailsState extends State<Postdetails> {
  late List<Comment> _comments = [];
  Map<Comment, bool> showReplyField = {};
  Map<Comment, TextEditingController> replyControllers = {};
  bool isLoading = true;
  String errorMessage = '';
  final TextEditingController _commentController = TextEditingController();
  int _currentPage = 0;
  final PageController _pageController = PageController();

  String? username;
  String? userImage;
  String? postContent;
  DateTime? postDate;
  int likes = 0;
  List<String> images = [];
  late bool _isLiked;
  CurrentUser? currentUser;
  
  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    _loadCurrentUser().then((_) => _loadPostDetails());
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Try to get user as a string
      final userData = prefs.getString('user');
      if (userData != null) {
        final decodedData = jsonDecode(userData);
        print('User data retrieved: $decodedData');
        return decodedData;
      }
      
      // Try to get user as a string list (fallback)
      final usersList = prefs.getStringList('user');
      if (usersList != null && usersList.isNotEmpty) {
        final decodedData = jsonDecode(usersList.first);
        print('User data retrieved from list: $decodedData');
        return decodedData;
      }
      
      print('No user data found in SharedPreferences');
      return {};
    } catch (e) {
      print('Error getting user data: $e');
      return {};
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      final userData = await getUserData();
      print("Retrieved user data: $userData");
      
      if (userData.isNotEmpty) {
        final userId = userData['userId']?.toString() ?? '';
        final userName = userData['username']?.toString() ?? 'User';
        final userProfilePic = userData['profile_picture']?.toString() ?? '';
        
        if (mounted) {
          setState(() {
            currentUser = CurrentUser(
              id: userId,
              name: userName,
              profilePic: userProfilePic,
            );
          });
          
          print("CurrentUser object set: ${currentUser?.name}");
        }
      } else {
        print("User data is empty");
      }
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  Future<void> _loadPostDetails() async {
    try {
      print('Fetching details for post ID: ${widget.postId}');
      final response = await ApiService.getPostDetails(widget.postId);
      print('API Response: $response');
      print('DEBUG - Post ID: ${widget.postId}');
      if (response['success'] != true || response['post'] == null) {
        throw Exception('Invalid response format or post not found');
      }
      
      final post = response['post'];
      
      setState(() {
        username = post['username'];
        userImage = post['profile_pic']; 
        postContent = post['content']; 
        
        try {
          postDate = DateTime.parse(post['created_at']);
        } catch (e) {
          print('Error parsing date: $e');
          postDate = DateTime.now();
        }

        likes = post['likes'] != null ? int.tryParse(post['likes'].toString()) ?? 0 : 0;
        if (post['media_url'] != null && post['media_url'] is List) {
          images = List<String>.from(post['media_url']);
        } else {
          images = [];
        }
        if (response['comments'] != null && response['comments'] is List) {
          _comments = (response['comments'] as List).map((comment) {
            return Comment(
              id: comment['commentid']?.toString() ?? '',
              userName: comment['username'] ?? 'Unknown',
              userImageUrl: comment['profile_pic'] ?? '', 
              text: comment['comment'] ?? '',
              timestamp: DateTime.tryParse(comment['created_at'] ?? '') ?? DateTime.now(),
              replies: [], 
              replyCount: comment['replies'] != null ? int.tryParse(comment['replies'].toString()) ?? 0 : 0,
            );
          }).toList();
        }
        
        isLoading = false;
      });
    } catch (e) {
      print('Error in _fetchPostDetails: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load post: $e';
      });
    }
  }

  Future<void> _toggleLike() async {
    try {
      bool newLikedState = !_isLiked;
      setState(() {
        _isLiked = newLikedState;
        if (newLikedState) {
          likes++;
        } else {
          likes--;
        }
      });

      final response = await ApiService.toggleLike(widget.postId); 
      if (response['success'] != true) {
        setState(() {
          _isLiked = !newLikedState; 
          if (_isLiked) {
            likes++;
          } else {
            likes--;
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
        _isLiked = !_isLiked; 
        if (_isLiked) {
          likes++;
        } else {
          likes--;
        }
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
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(errorMessage)),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        elevation: 18,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: userImage != null
                                  ? NetworkImage(userImage!)
                                  : const AssetImage('assets/img/user.png') as ImageProvider,
                              ),

                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    username ?? 'Unknown User',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(
                                    timeAgo(postDate ?? DateTime.now()),
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          
                          // Post content
                          Text(
                            postContent ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 12),
                          
                          // Images if available
                          if (images.isNotEmpty)
                            Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: images.length,
                                    onPageChanged: (int page) {
                                      setState(() {
                                        _currentPage = page;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            images[index],
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
                                // Add indicator dots
                                if (images.length > 1) ...[
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      images.length,
                                      (index) => AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(horizontal: 4),
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentPage == index ? const Color.fromARGB(255, 208, 33, 243) : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          
                          SizedBox(height: 16),
                          
                          // Likes section
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  (_isLiked) ? Icons.favorite : Icons.favorite_border,
                                  color: (_isLiked)? Colors.red : Colors.grey,
                                ),
                                onPressed: _toggleLike,
                              ), 
                              SizedBox(width: 4),
                              Text('$likes Likes'),
                              Spacer(),
                              Text('${_comments.length} Comments'),
                            ],
                          ),
                          Divider(),
                          Text(
                            'Comments',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    // Comments section
                    ..._comments.map((comment) {
                      return _buildCommentTile(comment);
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: currentUser?.profilePic != null
                      ? NetworkImage(currentUser!.profilePic)
                      : const AssetImage('assets/img/user.png') as ImageProvider,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 159, 30, 229),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        _postComment(_commentController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Future<void> _postComment(String commentText) async {
    if (currentUser == null) {
      await _loadCurrentUser();
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please log in to comment')),
        );
        print("Cannot post comment: User is not logged in");
        return;
      }
    }

    if (commentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment cannot be empty')),
      );
      return;
    }

    try {
      final response = await ApiService.postComment(widget.postId, commentText);
      
      if (response['success'] == true) {
        setState(() {
          _comments.add(
            Comment(
              id: response['commentId'] ?? '',
              userName: currentUser!.name,
              userImageUrl: currentUser!.profilePic,
              text: commentText,
              timestamp: DateTime.now(),
              replies: [],
              replyCount: 0,
            ),
          );
          _commentController.clear();
        });
      } else {
        throw Exception(response['message'] ?? 'Failed to post comment');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post comment: $e')),
      );
    }
  }

  Future<void> _postReply(Comment parentComment, String replyText) async {
    if (replyText.trim().isEmpty || currentUser == null) return;
    
    try {
      final response = await ApiService.postReply(parentComment.id, replyText.trim());
      
      if (response['success'] == true) {
        setState(() {
          parentComment.replies.add(Comment(
            id: response['reply_id'],
            userName: currentUser!.name,
            userImageUrl: currentUser!.profilePic,
            text: replyText.trim(),
            parent_id: parentComment.id,
            timestamp: DateTime.now(),
            isReply: true,
            replyCount: 0,
          ));
          
          // Increment parent comment's reply count
          parentComment.replyCount = (parentComment.replyCount ?? 0) + 1;
          
          replyControllers[parentComment]!.clear();
          showReplyField[parentComment] = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post reply: $e')),
      );
    }
  }

  Widget _buildCommentTile(Comment comment) {
    replyControllers.putIfAbsent(comment, () => TextEditingController());
    showReplyField.putIfAbsent(comment, () => false);

    return Container(
      margin: EdgeInsets.only(
        left: comment.isReply ? 40.0 : 8.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundImage: comment.userImageUrl.isNotEmpty
                      ? NetworkImage(comment.userImageUrl)
                      : const AssetImage('assets/img/user.png') as ImageProvider,
                ),
                SizedBox(width: 12),
                // Comment Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.userName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6),
                          Expanded( // Wrap this in Expanded to handle overflow
                            child: Text(
                              timeAgo(comment.timestamp),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Fixed report/menu button
                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'delete') {
                                showDeleteConfirmationDialog(context, comment.id);
                              } else if (value == 'report') {
                                showReportOptions(context, (reason) {
                                  _reportcomment(context, comment.id, reason);
                                });
                              }
                            },
                            icon: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ),
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
                              if (currentUser?.name == comment.userName)
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
                      SizedBox(height: 6),
                      Text(
                        comment.text,
                        style: TextStyle(fontSize: 14.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                SizedBox(width: 52),
                if (!comment.isReply)
                  Wrap( // Changed Row to Wrap for better handling of small screens
                    spacing: 8, // Space between children
                    children: [
                      // Always show the replies button for non-reply comments
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            comment.showReplies = !comment.showReplies;
                            // Always fetch replies when opening the replies section
                            if (comment.showReplies) {
                              _getRepliesForComment(comment);
                            }
                          });
                        },
                        icon: Icon(
                          comment.showReplies ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 16,
                          color: const Color.fromARGB(255, 159, 30, 229),
                        ),
                        label: Text(
                          "${comment.replyCount ?? 0} ${(comment.replyCount ?? 0) == 1 ? 'Reply' : 'Replies'}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 159, 30, 229),
                            fontSize: 13,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          ),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            showReplyField[comment] = !showReplyField[comment]!;
                            if (showReplyField[comment]!) {
                              comment.showReplies = true;
                              // Always fetch replies when opening the reply field
                              _getRepliesForComment(comment);
                            }
                          });
                        },
                        icon: Icon(
                          Icons.reply,
                          size: 16,
                          color: const Color.fromARGB(255, 159, 30, 229),
                        ),
                        label: Text(
                          "Reply",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 159, 30, 229),
                            fontSize: 13,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          ),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Reply field
          if (showReplyField[comment]! && !comment.isReply)
            Padding(
              padding: const EdgeInsets.fromLTRB(52, 0, 12, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    // User Avatar
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: currentUser?.profilePic != null
                            ? NetworkImage(currentUser!.profilePic)
                            : const AssetImage('assets/img/user.png') as ImageProvider,
                      ),
                    ),
                    SizedBox(width: 8),
                    // Reply TextField
                    Expanded(
                      child: TextField(
                        controller: replyControllers[comment],
                        decoration: InputDecoration(
                          hintText: "Write a reply...",
                          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    // Send Button
                    IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: const Color.fromARGB(255, 159, 30, 229),
                      ),
                      onPressed: () {
                        final replyText = replyControllers[comment]!.text;
                        if (replyText.trim().isNotEmpty) {
                          _postReply(comment, replyText.trim());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (!comment.isReply && comment.showReplies)
            Column(
              children: [
                if (comment.isLoadingReplies)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  ...comment.replies.map((reply) => Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: _buildCommentTile(reply),
                  )).toList(),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _getRepliesForComment(Comment comment) async {
    try {
      // Show loading indicator while loading
      setState(() {
        comment.isLoadingReplies = true;
        // Clear previous replies to avoid duplicates
        comment.replies = [];
      });
      
      final response = await ApiService.getReplies(comment.id);
      print('Replies response: $response'); // Debug
      
      if (response['success'] == true && response['replies'] is List) {
        List<Comment> replyComments = [];
        
        for (var replyData in response['replies']) {
          final replyId = replyData['commentid']?.toString() ?? '';
          
          // Check if this reply is already in our list to avoid duplicates
          final existingReplyIndex = comment.replies.indexWhere((r) => r.id == replyId);
          if (existingReplyIndex == -1) { // Only add if it doesn't exist already
            replyComments.add(Comment(
              id: replyId.toString(),
              userName: replyData['username'] ?? 'Unknown',
              userImageUrl: replyData['profile_pic'] ?? '',
              text: replyData['comment'] ?? '',
              timestamp: DateTime.tryParse(replyData['created_at'] ?? '') ?? DateTime.now(),
              isReply: true,
              parent_id: comment.id,
              replies: [],
              showReplies: false,
              replyCount: 0,
            ));
          }
        }
        
        setState(() {
          comment.replies = replyComments;
          comment.replyCount = replyComments.length;
          comment.isLoadingReplies = false;
        });
      } else {
        setState(() {
          comment.isLoadingReplies = false;
        });
      }
    } catch (e) {
      print('Error fetching replies: $e');
      setState(() {
        comment.isLoadingReplies = false;
      });
    }
  }

  Future<void> _reportcomment(BuildContext context, String postId, String reason) async {
    try{
      final response = await ApiService.reportitem(postId, reason, 'comment');
      if(response['success'] == true){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to report comment: $e')),
      );
    }
  }

  void showDeleteConfirmationDialog(BuildContext context, String commentId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Confirm Delete"),
          content: Text("Do you want to delete this comment?"),
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
                await deletecomment(context, commentId); // Call your delete function
              },
            ),
          ],
        );
      },
    );
  }

Future<void> deletecomment(BuildContext context,String commentId) async {

  try{
    final response =await ApiService.deletecomment(
      commentId
    );
    if(response['success']==true){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),);
    }
  }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete comment: $e')),
      );
    }
}
}