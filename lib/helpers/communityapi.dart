// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_project/theApp_screans.dart/models/comunnity.dart';
class ApiService {
  static const String baseUrl = 'https://books-paradise.onrender.com';
static Future<List<Community>> getPosts() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/community/posts'),
      headers: {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'},


    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      if (data['success'] == true && data['posts'] != null) {
        final List<dynamic> postsData = data['posts'];
        
        return postsData.map((post) {
          List<String> images = [];
          final mediaUrl = post['media_url'];
          if (mediaUrl != null) {
            try {
              if (mediaUrl is List) {
                images = mediaUrl.whereType<String>().toList();
              } else if (mediaUrl is String) {
                if (mediaUrl.startsWith('[')) {
                  final List<dynamic> mediaList = json.decode(mediaUrl);
                  images = mediaList.whereType<String>().toList();
                } else {
                  images.add(mediaUrl);
                }
              }
            } catch (e) {
              print('Error parsing media URLs: $e');
              if (mediaUrl is String) {
                images.add(mediaUrl);
              }
            }
          }
          DateTime createdAt;
          try {
            createdAt = DateTime.parse(post['created_at']?.toString() ?? '');
          } catch (e) {
            createdAt = DateTime.now();
            print('Error parsing date: $e');
          }
          int parseInt(dynamic value) {
            if (value == null) return 0;
            if (value is int) return value;
            if (value is String) return int.tryParse(value) ?? 0;
            return 0;
          }

          return Community(
            postId: post['postid']?.toString() ?? '',
            username: post['username']?.toString() ?? 'Anonymous',
            userimage: post['profile_pic']?.toString() ?? 'assets/img/user.png',
            content: post['content']?.toString() ?? '',
            createdAt: createdAt,
            likes: parseInt(post['likes']),
            isLiked: false, 
            mediaUrls: images,
            commentsCount: parseInt(post['comments']),
            is_liked: post['liked_by_current_user']
          );
        }).toList();
      }
    }
    throw Exception('Failed to load posts: ${response.statusCode}');
  } catch (e) {
    print('Error getting posts: $e');
    throw Exception(' Please check your internet connection and try again.');
  }
}
  
  static Future<Map<String, dynamic>> getPostDetails(String postId) async {
  try {
    final url = '$baseUrl/community/post/$postId';
    print('Requesting: $url');
    print('DEBUG - Post ID: $postId');
    // Add authentication if needed
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load post details: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception in getPostDetails: $e');
    throw Exception('Error fetching post details: Please check your internet connection and try again.');
  }
}

 static Future<Map<String, dynamic>> deletepost(String postId) async {
  try {
    final url = '$baseUrl/community/delete-post/$postId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to delete post: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception in deleting post: $e');
    throw Exception('Error deleting post: Please check your internet connection and try again.');
  }
}


static Future<Map<String, dynamic>> toggleLike(String postId) async {
  try {
    // Validate postId
    if (postId.isEmpty) {
      throw Exception('Post ID cannot be empty');
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found or invalid');
    }
    
    final response = await http.post(
      Uri.parse('$baseUrl/community/like'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'post_id': postId,
      }),
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data['success']==true) {
          return data;
        } else {
          throw Exception('Invalid response format from server');
        }
      } catch (e) {
        throw Exception('Failed to parse server response: Please check your internet connection and try again.');
      }
    }
    else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    print('Network error in toggleLike: $e');
    return {
      'success': false, 
      'message': 'Network error: ${e.message}',
      'error': 'network_error'
    };
  } on FormatException catch (e) {
    print('JSON parsing error in toggleLike: $e');
    return {
      'success': false, 
      'message': 'Invalid server response',
      'error': 'parse_error'
    };
  } catch (e) {
    print('Unexpected error in toggleLike: $e');
    return {
      'success': false, 
      'message': 'Please check your internet connection and try again.',
      'error': 'unexpected_error'
    };
  }
}
static Future<Map<String, dynamic>> postComment(String postId, String commentText) async {
  try {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //print("hkasdhfkadhsfofhaj $postId");
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }
    
    final response = await http.post(
      Uri.parse('$baseUrl/community/comment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'post_id': postId,
        'comment': commentText,
        'parent_comment_id': null 
      }),
    );
    
    final responseData = jsonDecode(response.body);
    
    if (response.statusCode == 201) {
      return {
        'success': true,
        'commentId': responseData['comment']['commentid'].toString(),
        'created_at': responseData['comment']['created_at'],
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to post comment',
      };
    }
  } catch (e) {
    print('Error posting comment: $e');
    return {'success': false, 'message': 'Please check your internet connection and try again.'};
  }
}


static Future<Map<String, dynamic>> postReply(String commentId, String replyText) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }
    

    final postIdResponse = await http.get(
      Uri.parse('$baseUrl/community/getpostid/$commentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    
    if (postIdResponse.statusCode != 200) {
      return {'success': false, 'message': 'Failed to get comment details'};
    }
    
    final commentData = jsonDecode(postIdResponse.body);
    final String postId = commentData['postId'].toString();
    

    final response = await http.post(
      Uri.parse('$baseUrl/community/comment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'post_id': postId,
        'comment': replyText,
        'parent_comment_id': commentId 
      }),
    );
    
    final responseData = jsonDecode(response.body);
    
    if (response.statusCode == 201) {
      return {
        'success': true,
        'reply_id': responseData['comment']['commentid'].toString(),
        'parent_id':responseData['comment']['parent_comment_id'].toString(),
        'created_at': responseData['comment']['created_at'].toString(),
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to post reply',
      };
    }
  } catch (e) {
    print('Error posting reply: $e');
    return {'success': false, 'message': 'Please check your internet connection and try again.'};
  }
}


static Future<Map<String, dynamic>> reportitem(String itemId, String reason,String type) async {
  try {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }
    
    final response = await http.post(
      Uri.parse('$baseUrl/report/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'reported_item_id': itemId,
        'report_type': reason,
        'item_type': type
      }),
    );
    
    final responseData = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': responseData['message'] ?? 'Report sent.',
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to send report.',
      };
    }
  } catch (e) {
    print('Error reporting comment: $e');
    return {'success': false, 'message': 'Please check your internet connection and try again.'};
  }
}
static Future<Map<String, dynamic>> deletecomment(String commentId) async {
  try {
    final url = '$baseUrl/community/delete-comment/$commentId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );
    final responseData = jsonDecode(response.body);
     if (response.statusCode == 200) {
      return {
        'success': true,
        'message': responseData['message'] ?? 'comment has been deleted.',
      };
    } else {
      return {
        'success': false,
        'message': responseData['message'] ?? 'Failed to delete comment.',
      };
    }
  } catch (e) {
    print('Exception in deleting post: $e');
    throw Exception('Error deleting comment: Please check your internet connection and try again.');
  }
}
static Future<Map<String, dynamic>> getReplies(String commentId) async {
  try {
    final url = '$baseUrl/community/comment/$commentId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
   final responseData = jsonDecode(response.body);
     if (response.statusCode == 200) {
      return 
         responseData;
      
    } else {
      return {
        'success': false,
      };
    }
  } catch (e) {
    print('Exception in deleting post: $e');
    throw Exception(' Please check your internet connection and try again.');
  }
}
}


