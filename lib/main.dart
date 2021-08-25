import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/user.dart';
import 'package:share_learning/screens/single_post_screen.dart';
import 'package:share_learning/screens/user_posts_screen.dart';
import 'screens/home_screen.dart';

// import './widgets';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Books()),
        ChangeNotifierProvider.value(value: Comments()),
        ChangeNotifierProvider.value(value: Users()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Share Your Learning',
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          accentColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: HomeScreen(),
        // home: TestScreen(),
        routes: {
          SinglePostScreen.routeName: (context) => SinglePostScreen(),
          UserPostsScreen.routeName: (context) => UserPostsScreen(),
        },
      ),
    );
  }
}
