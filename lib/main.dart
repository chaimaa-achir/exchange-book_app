
import 'package:flutter/material.dart';

import 'package:mini_project/Cashdatasave/cashhelper.dart';

import 'package:mini_project/theApp_screans.dart/screans/book-details.dart';
import 'package:mini_project/theApp_screans.dart/screans/request-screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready
  await CacheData.cacheInitialisations(); // Initialize SharedPreferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home:requestPAge (),
    );
  }
}
