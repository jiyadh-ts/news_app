// lib/main.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/controller/detailscreencontroller.dart';
import 'package:news_app/controller/homescreencontroller.dart';
import 'package:news_app/controller/seachscreencontroller.dart';
import 'package:news_app/model/article.dart'; // Ensure correct path
import 'package:news_app/view/BottomNavigationBar.dart/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ArticleAdapter()); // Register the ArticleAdapter

  // Open Hive boxes
  // await Hive.openBox<Articles>("bookmarks"); // Open the 'bookmarks' box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homescreencontroller()),
        ChangeNotifierProvider(create: (context) => DetailScreenController()),
        ChangeNotifierProvider(create: (context) => Searchscreencontroller()),
      ],
      child: MaterialApp(
        
        home: BottomNavbarScreen(),
      ),
    );
  }
}
