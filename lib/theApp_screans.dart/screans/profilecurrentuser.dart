// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mini_project/theApp_screans.dart/screans/followersPage.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileCurrentUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileCurrentUserScreen({super.key, required this.user});

  @override
  State<ProfileCurrentUserScreen> createState() =>
      _ProfileCurrentUserScreenState();
}

class _ProfileCurrentUserScreenState extends State<ProfileCurrentUserScreen> {
  String aboutUser = "";
  File? _profileImage;
  String? profileImageUrl;
  List<Map<String, dynamic>> userBooks = [];
  late Future<List<Map<String, dynamic>>> userBooksFuture;
  Map<String, dynamic>? followerData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
    loadFollowerCount();
    userBooksFuture = fetchProfileData();
  }

  Future<void> loadUserProfile() async {
    final profileData = await fetchProfile();
    if (mounted) {
      setState(() {
        aboutUser = profileData['bio'] ?? widget.user['bio'] ?? '';
        profileImageUrl = profileData['profile_pic'];
      });
    }
  }

  Future<void> loadFollowerCount() async {
    final data = await followercount();
    if (mounted) {
      setState(() {
        followerData = data;
        isLoading = false;
      });
    }
  }

  Future<String?> getbio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return userMap['bio'];
    }
    return null;
  }
    
  Future<void> pickImageForProfile() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await updateprofile();
    }
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> updateprofile() async {
    try {
      String token = await getToken();
      final uri = Uri.parse("https://books-paradise.onrender.com/profile/update-pic");
      
      final request = http.MultipartRequest('PATCH', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath('profile', _profileImage!.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Profile picture has been updated');
        // Update the profile image URL after successful upload
        final responseData = json.decode(response.body);
        setState(() {
          profileImageUrl = responseData['profile_pic'];
        });
      } else {
        print('Failed to update profile picture: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Connection error: $e');
    }
  }

  Future<void> updateBio(String newBio, String token) async {
    final url = Uri.parse('https://books-paradise.onrender.com/profile/add-bio');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'bio': newBio,
        }),
      );

      if (response.statusCode == 200) {
        print('Updated effective bio');
        // Update the local state with the new bio
        setState(() {
          aboutUser = newBio;
        });
      } else {
        print('Bio update failed, code: ${response.statusCode}');
      }
    } catch (e) {
      print('Connection error: $e');
    }
  }

  Future<Map<String, dynamic>?> followercount() async {
    String token = await getToken();
    final url = Uri.parse('https://books-paradise.onrender.com/follow/count-followers');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'followers': data['followers'],
          'following': data['following'],
        };
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Connection error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    String token = await getToken();
    final url = Uri.parse('https://books-paradise.onrender.com/profile/user-profile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'profile_pic': data['profile_pic'],
          'bio': data['bio'],
        };
      } else {
        print('Failed to load profile, code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Connection error: $e');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> fetchProfileData() async {
    String token = await getToken();
    final prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');
    final url = Uri.parse('https://books-paradise.onrender.com/profile/posted-books?userLat=$latitude&userLon=$longitude');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['books']);
      } else {
        print('Failed to load books, code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Connection error: $e');
      return [];
    }
  }
  
  Future<bool> deleteBook(String bookId) async {
    String token = await getToken();
    final url = Uri.parse('https://books-paradise.onrender.com/profile/delete-book/$bookId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print('Book deleted successfully');
        return true;
      } else {
        print('Failed to delete book, code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Connection error while deleting book: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    DateTime signupDate = DateTime.parse(widget.user["signup_date"]);
    String formattedDate = DateFormat("yyyy MMMM d").format(signupDate);

    return Scaffold(
      appBar: AppBar(title: Text(widget.user['username'])),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _getProfileImage(),
                    ),
                    Positioned(
                      bottom: screenHeight * -0.015,
                      right: screenWidth * -0.02,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey, size: 30),
                        onPressed: pickImageForProfile,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowersScreen(isFollowers: true)),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        isLoading ? '...' : "${followerData?['followers'] ?? 0}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Followers"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowersScreen(isFollowers: false)),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        isLoading ? '...' : "${followerData?['following'] ?? 0}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Following"),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final newBio = await showDialog<String>(
                    context: context,
                    builder: (_) => _buildEditBioDialog(context, aboutUser),
                  );
                  if (newBio != null && newBio.isNotEmpty) {
                    String token = await getToken();
                    await updateBio(newBio, token);
                  }
                },
                icon: Icon(Icons.edit_note, color: Colors.white),
                label: Text("Edit About", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 182, 166, 247),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: screenHeight * 0.015),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey, size: 16),
                Text(
                  "  You joined in $formattedDate",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("About you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              aboutUser.isNotEmpty ? aboutUser : "No bio added yet...",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            Text("📚 Books Posted",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: userBooksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('An error occurred while loading books.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No books have been published yet.'));
                } else {
                  final books = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      book["cover_image"],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    if (!book["disponibility"])
                                      Positioned.fill(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: Container(
                                            color: Colors.black.withOpacity(0.3),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Not Available",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: _getStatusColor(book["transaction_type"]),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                book["transaction_type"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              book["title"],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "BY ${book["author"]}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: const Color.fromARGB(255, 96, 95, 95)),
                                            ),
                                            if (book["transaction_type"] == "Sale") ...[
                                              Text(
                                                " ${book["price"]} DA",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: const Color.fromARGB(255, 96, 95, 95)),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _showDeleteConfirmation(context, book),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to determine which profile image to display
  ImageProvider _getProfileImage() {
    if (_profileImage != null) {
      // If there's a locally selected image, show it first
      return FileImage(_profileImage!);
    } else if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      // If there's a remote profile image URL, show it
      return NetworkImage(profileImageUrl!);
    } else if (widget.user['profileImage'] != null) {
      // Fallback to the user's profile image from widget.user
      return NetworkImage(widget.user['profileImage']);
    } else {
      // Default profile image
      return AssetImage("assets/img/user.png");
    }
  }

  Widget _buildEditBioDialog(BuildContext context, String currentBio) {
    TextEditingController controller = TextEditingController(text: currentBio);
    return AlertDialog(
      title: Text("Edit Bio"),
      content: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: "Write something about yourself...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text("Save")),
      ],
    );
  }
  
  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> book) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Delete Book"),
          content: Text("Are you sure you want to delete '${book["title"]}'? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                // Close the confirmation dialog first
                Navigator.of(dialogContext).pop();
                
                // Store the scaffold messenger context
                final scaffoldContext = context;
                
                // Show loading indicator
                showDialog(
                  context: scaffoldContext,
                  barrierDismissible: false,
                  builder: (BuildContext loadingContext) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                
                // Call the delete API
                final success = await deleteBook(book["bookid"].toString());
                
                // Check if context is still valid before proceeding
                if (!mounted) return;
                
                // Dismiss loading indicator
                Navigator.of(scaffoldContext).pop();
                
                // Check again if context is still valid
                if (!mounted) return;
                
                if (success==true) {
                  // Show success message
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text("Book deleted successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  
                  // Refresh the books list
                  if (mounted) {
                    setState(() {
                      userBooksFuture = fetchProfileData();
                    });
                  }
                } else {
                  // Show error message
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    SnackBar(
                      content: Text("Failed to delete book. Please try again."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Exchange":
        return Colors.blue;
      case "Lending":
        return Colors.green;
      case "Sale":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}