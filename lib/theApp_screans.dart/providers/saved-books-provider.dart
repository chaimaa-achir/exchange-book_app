// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_project/theApp_screans.dart/models/book.dart';

class SavedBooksProvider extends ChangeNotifier {
  List<Book> savedBooks = [];

  bool isSaved(Book book) => savedBooks.contains(book);

  void toggleSaveBook(Book book) {
    if (isSaved(book)) {
      savedBooks.remove(book);
    } else {
      savedBooks.add(book);
    }
    notifyListeners(); // Updates UI when a book is added or removed
  }
}
