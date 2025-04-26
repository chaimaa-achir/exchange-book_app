// ignore_for_file: non_constant_identifier_names

class Comment {
  final String userName;
  final String userImageUrl;
  final String text;
  final DateTime timestamp;
  List<Comment> replies;
  final bool isReply;
  
  

  Comment({
    required this.userName,
    required this.userImageUrl,
    required this.text,
    required this.timestamp,
    List<Comment>? replies,
    this.isReply = false,
    
    
  }): replies = replies ?? [];
}

class Community {
  final String userimage;
  final String username;
  final List<String> imagesCommunity;
  final String Forum;
  final DateTime Cpostdate;
  bool isLiked;
  
  int numberlikes;
  final List<Comment> comments;
  Community({
    required this.Cpostdate,
    required this.username,
    required this.userimage,
    required this.Forum,
    this.numberlikes = 4,
    this.comments = const [],
    this.isLiked=false,
    
    List<String>? imagesCommunity,
  }) : imagesCommunity = imagesCommunity ?? [];
}

List<Community> communitylist = [
  Community(
    userimage: "assets/img/history.jpg",
    username: " username",
    Cpostdate: DateTime(2025, 3, 25, 14, 30),
    Forum:
    " 🔍 Why this works best for your case:The list is optional when creating the object.If the backend sends no images → it defaults to an empty list.If it sends images → they get stored normally.You can still modify the list later if needed (e.g., in UI or business logic).",
    
    numberlikes: 23,
    comments: [
      Comment(
          userName: "Ali",
          text: "Nice post!",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
      Comment(
          userName: "Sara",
          text: "Thank you for sharing.",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30),
          isReply: true,
           replies: [
        Comment(
          userName: "Alice",
          userImageUrl: "assets/img/history.jpg",
          text: "Thank you!",
          timestamp: DateTime.now().subtract(Duration(minutes: 20)),
        ),
        Comment(
          userName: "Jhosef",
          userImageUrl: "assets/img/history.jpg",
          text: "Thank you!",
          timestamp: DateTime.now().subtract(Duration(minutes: 20)),
        ),
      ],
          ),
          
    ],
  ),
  Community(
    userimage: "assets/img/history.jpg",
    username: " username",
    Cpostdate: DateTime(2025, 3, 25, 14, 30),
    Forum:
        " hell evryone my name iss chaimaa i want a book of jjhghjghjghjgjhgjg",
    imagesCommunity: [
      "assets/img/history.jpg",
      "assets/img/history.jpg",
      "assets/img/history.jpg",
      "assets/img/history.jpg",
    ],
    
    numberlikes: 11,
    comments: [
      Comment(
          userName: "Ali",
          text: "Nice post!",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
      Comment(
          userName: "Sara",
          text: "Thank you for sharing.",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
          Comment(
          userName: "Maya",
          text: "With the widgets and routes in place, trigger navigation by using the Navigator.pushNamed() method. This tells Flutter to build the widget defined in the routes table and launch the screen.",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
      Comment(
          userName: "Sara",
          text: "Thank you for sharing.",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
    ],
  ),
  Community(
    userimage: "assets/img/history.jpg",
    username: " username",
    Cpostdate: DateTime(2025, 3, 25, 14, 30),
    Forum:
        "hell evryone my name iss chaimaa i want a book of jjhghjghjghjgjhgjg",
    imagesCommunity: [
      "assets/img/history.jpg",
      "assets/img/history.jpg",
    ],
    
    numberlikes: 23,
    comments: [
      Comment(
          userName: "Ali",
          text: "Nice post!",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
      Comment(
          userName: "Sara",
          text: "Thank you for sharing.",
          userImageUrl: "assets/img/history.jpg",
          
          timestamp: DateTime(2025, 3, 25, 14, 30)),
    ],
  ),
  Community(
    userimage: "assets/img/history.jpg",
    username: " username",
    Cpostdate: DateTime(2025, 3, 25, 14, 30),
    Forum:
        " hell evryone my name iss chaimaa i want a book of jjhghjghjghjgjhgjg",
    
    numberlikes: 23,
  ),
  Community(
    userimage: "assets/img/history.jpg",
    username: " username",
    Cpostdate: DateTime(2025, 3, 25, 14, 30),
    Forum:
        " hell evryone my name iss chaimaa i want a book of jjhghjghjghjgjhgjg",
    imagesCommunity: [
      "assets/img/history.jpg",
    ],
    
    numberlikes: 23,
  ),
];
