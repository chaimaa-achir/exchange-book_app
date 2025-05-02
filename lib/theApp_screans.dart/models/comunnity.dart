
class Community {
  final String postId;
  final String username;
  final String userimage;
  final String content;
  final DateTime createdAt;
  final List<String> mediaUrls;
  int likes;
  int commentsCount;
  bool is_liked;
  bool isLiked;

  Community({
    required this.postId,
    required this.username,
    required this.userimage,
    required this.content,
    required this.createdAt,
    required this.mediaUrls,
    required this.likes,
    required this.commentsCount,
    required this.is_liked,
    this.isLiked=false,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      postId: json['postid'].toString(),
      username: json['username'] ?? 'Anonymous',
      userimage: json['profile_pic'] ?? 'assets/img/user.png',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      mediaUrls: (json['media_url'] is List)
          ? List<String>.from(json['media_url'])
          : (json['media_url'] != null ? [json['media_url'].toString()] : []),
      likes: int.tryParse(json['likes']?.toString() ?? '0') ?? 0,
      commentsCount: int.tryParse(json['comments']?.toString() ?? '0') ?? 0,
      is_liked: json['liked_by_current_user']
     // is_liked: json['is_liked'],
    );
  }
}