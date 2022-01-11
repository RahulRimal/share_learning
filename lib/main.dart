import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/user.dart';
import 'package:share_learning/templates/managers/strings_manager.dart';
import 'package:share_learning/templates/managers/theme_manager.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';
import 'package:share_learning/templates/screens/single_post_screen.dart';
import 'package:share_learning/templates/screens/splash_screen.dart';
import 'package:share_learning/templates/screens/user_posts_screen.dart';

import 'templates/screens/edit_post_screen.dart';
import 'templates/screens/home_screen.dart';

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
        title: AppStrings.appTitle,
        // theme: ThemeData(
        //   primaryColor: Colors.redAccent,
        //   accentColor: Colors.blueAccent,
        //   scaffoldBackgroundColor: Colors.grey[100],
        // ),
        theme: getApplicationTheme(),
        // home: HomeScreen(),
        home: SplashScreen(),
        // home: AddPostScreen(),
        routes: {
          SinglePostScreen.routeName: (context) => SinglePostScreen(),
          UserPostsScreen.routeName: (context) => UserPostsScreen(),
          AddPostScreen.routeName: (context) => AddPostScreen(),
          EditPostScreen.routeName: (context) => EditPostScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
        },
      ),
    );
  }
}
