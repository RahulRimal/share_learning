import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// import './widgets';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Your Learning',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomeScreen(),
    );
  }
}
