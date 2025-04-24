import 'package:flutter/material.dart';
import 'package:mini_project/helpers/comment_utils.dart';
import 'package:mini_project/helpers/time_utils.dart';
import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
import 'package:mini_project/theApp_screans.dart/widgets/report_dailog.dart';

class Postdetails extends StatefulWidget {
  const Postdetails({super.key, required this.community});
  final Community community;

  @override
  State<Postdetails> createState() => _PostdetailsState();
}

class _PostdetailsState extends State<Postdetails> {
  late List<Comment> _comments;
  Map<Comment, bool> showReplyField = {};
  Map<Comment, TextEditingController> replyControllers = {};
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.community.comments);
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundImage:
                                      AssetImage(widget.community.userimage),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.community.username,
                                              style:
                                                  TextStyle(fontSize: 18)),
                                          InkWell(
                                            onTap:(){
                                              showReportOptions(context, (selectedReason) {
                                         print("the reason:$selectedReason");
                                      });
                                            },
                                            child: Icon(Icons.flag_outlined, size: 26)
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time,
                                              color: Colors.grey, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                              timeAgo(widget
                                                  .community.Cpostdate),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.community.Forum,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03,
                                ),
                                if (widget.community.imagesCommunity
                                    .isNotEmpty) ...[
                                  Divider(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.25,
                                        width: double.infinity,
                                        child: PageView.builder(
                                          controller: _pageController,
                                          itemCount: widget.community
                                              .imagesCommunity.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.asset(
                                                  widget.community
                                                      .imagesCommunity[index],
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            widget.community.imagesCommunity
                                                .length, (index) {
                                          return AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            width: _currentPage == index
                                                ? 12
                                                : 8,
                                            height: _currentPage == index
                                                ? 12
                                                : 8,
                                            decoration: BoxDecoration(
                                              color: _currentPage == index
                                                  ? Color.fromARGB(
                                                      255, 160, 107, 186)
                                                  : Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(36, 158, 158, 158),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.question_answer_outlined),
                            Text(
                              "${countAllComments(_comments)} comments",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: screenHeight * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.community.isLiked =
                                      !widget.community.isLiked;
                                  if (widget.community.isLiked) {
                                    widget.community.numberlikes++;
                                  } else {
                                    widget.community.numberlikes--;
                                  }
                                });
                              },
                              child: Icon(
                                widget.community.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.community.isLiked
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              "${widget.community.numberlikes} likes",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ..._comments.map((Comment) {
                      return _buildCommentTile(Comment);
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Leave your comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_commentController.text.trim().isNotEmpty) {
                      setState(() {
                        _comments.add(
                          Comment(
                            userName: 'You',
                            userImageUrl: "assets/img/history.jpg",
                            text: _commentController.text.trim(),
                            timestamp: DateTime.now(),
                          ),
                        );
                        _commentController.clear();
                      });
                    }
                  },
                  child: Text("Post"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildCommentTile(Comment comment) {
    showReplyField.putIfAbsent(comment, () => false);
    replyControllers.putIfAbsent(comment, () => TextEditingController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(comment.userImageUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(comment.userName,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: (){
                    showReportOptions(context, (selectedReason) {
                    print("the reason:$selectedReason");
                  });
                  },
                  child: Icon(Icons.flag_outlined)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.text),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey, size: 17),
                    SizedBox(width: 4),
                    Text(timeAgo(comment.timestamp),
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showReplyField[comment] = !showReplyField[comment]!;
                        });
                      },
                      child: Text("Reply", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                if (showReplyField[comment]!) ...[
                  SizedBox(height: 8),
                  TextField(
                    controller: replyControllers[comment],
                    decoration: InputDecoration(
                      hintText: "Write a reply...",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          final replyText = replyControllers[comment]!.text;
                          if (replyText.trim().isNotEmpty) {
                            setState(() {
                              comment.replies.add(Comment(
                                userName: "You",
                                userImageUrl: 'assets/img/history.jpg',
                                text: replyText.trim(),
                                timestamp: DateTime.now(),
                                isReply: true,
                              ));
                              replyControllers[comment]!.clear();
                              showReplyField[comment] = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ...comment.replies.map((reply) => _buildCommentTile(reply)),
        ],
      ),
    );
  }
}
