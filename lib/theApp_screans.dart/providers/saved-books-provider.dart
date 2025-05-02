// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project/theApp_screans.dart/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedBooksProvider extends ChangeNotifier {
  List<Book> _savedBooks = [];

  List<Book> get savedBooks => _savedBooks;

  bool isSaved(Book book) {
    return _savedBooks.any((b) => b.bookid == book.bookid);
  }

  Future<void> saveBook(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token not found');
      return;
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // فقط حفظ الكتاب
    final url = Uri.parse('https://books-paradise.onrender.com/saved/save');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'book_id': book.bookid}),
    );

    if (response.statusCode == 200) {
      if (!_savedBooks.any((b) => b.bookid == book.bookid)) {
        _savedBooks.add(book);
        notifyListeners();
      }
    } else {
      print('Failed to save the book: ${response.body}');
    }
  }

Future<void> fetchSavedBooks() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final userLat = prefs.getDouble('latitude');
  final userLon = prefs.getDouble('longitude');

  if (token == null) {
    print('Token not found');
    return;
  }

  if (userLat == null || userLon == null) {
    print('User location not found');
    return;
  }

  final url = Uri.parse(
    'https://books-paradise.onrender.com/saved/get-saved-books?userLat=$userLat&userLon=$userLon',
  );

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    _savedBooks = data.map((json) => Book.fromJson(json)).toList();
    notifyListeners();
  } else {
    print('Failed to retrieve saved books: ${response.statusCode}');
  }
}

}
