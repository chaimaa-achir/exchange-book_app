/*late Duration difference;
  String get timeAgo {
    difference = DateTime.now().difference(postDate);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${(difference.inDays / 7).floor()} weeks ago";
    }
  }
}*/
String timeAgo(DateTime date) {
  final duration = DateTime.now().difference(date);
  if (duration.inSeconds < 60) {
      return "${duration.inSeconds} seconds ago";
    } else if (duration.inMinutes < 60) {
      return "${duration.inMinutes} minutes ago";
    } else if (duration.inHours < 24) {
      return "${duration.inHours} hours ago";
    } else if (duration.inDays < 7) {
      return "${duration.inDays} days ago";
    } else {
      return "${(duration.inDays / 7).floor()} weeks ago";
    }
  }
