class Comment {
  final String id;
  final String userName;
  final String userImageUrl;
  final String text;
  final DateTime timestamp;
  final String? parent_id;
  List<Comment> replies;
  bool showReplies;
  bool isReply;
  int? replyCount; 
  bool isLoadingReplies = false; 
  Comment({
    required this.id,
    required this.userName,
    required this.userImageUrl,
    required this.text,
    required this.timestamp,
    this.parent_id,
    this.replies = const [],
    this.showReplies = false,
    this.isReply = false,
    this.replyCount = 0,
  });
}