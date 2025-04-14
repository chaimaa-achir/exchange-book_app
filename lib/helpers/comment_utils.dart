import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';

int countAllComments(List<Comment> comments) {
  int count = 0;

  for (var comment in comments) {
    count++; // count the comment
    count += countAllComments(comment.replies); // count replies recursively
  }

  return count;
}