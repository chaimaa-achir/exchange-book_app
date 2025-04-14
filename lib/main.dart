import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mini_project/Authentication_sreans.dart/login.dart';

import 'package:mini_project/intro_screans.dart/onbording_screan.dart';
import 'package:mini_project/theApp_screans.dart/navigationbottombar.dart';
import 'package:mini_project/theApp_screans.dart/providers/saved-books-provider.dart';
import 'package:mini_project/theApp_screans.dart/screans/chatscreen.dart';
import 'package:mini_project/theApp_screans.dart/screans/meesagePage.dart';
import 'package:provider/provider.dart';





void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(  // Wrap with MultiProvider for state management
      providers: [
        ChangeNotifierProvider(create: (context) => SavedBooksProvider()),  // Register SavedBooksProvider
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        showPerformanceOverlay: false,
        
        home:   Navigationbar(),
      ),
    );
  }
}
