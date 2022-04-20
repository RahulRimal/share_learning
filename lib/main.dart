import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/sessions.dart';
import 'package:share_learning/providers/users.dart';
import 'package:share_learning/templates/managers/strings_manager.dart';
import 'package:share_learning/templates/managers/theme_manager.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';
import 'package:share_learning/templates/screens/login_signup_screen.dart';
import 'package:share_learning/templates/screens/onboarding_screen.dart';
import 'package:share_learning/templates/screens/signup_screen.dart';
import 'package:share_learning/templates/screens/single_post_screen.dart';
import 'package:share_learning/templates/screens/splash_screen.dart';
import 'package:share_learning/templates/screens/login_screen.dart';
import 'package:share_learning/templates/screens/user_posts_screen.dart';
import 'package:share_learning/templates/screens/user_profile_screen.dart';
import 'package:share_learning/templates/widgets/app_drawer.dart';

import 'templates/screens/edit_post_screen.dart';
import 'templates/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        // ChangeNotifierProvider.value(value: Books()),
        // ChangeNotifierProxyProvider<SessionProvider, Books>(
        //   // create: (_) => Books(),
        //   create: (_) => Books(),
        //   update: (ctx, session, previousSession) => Books(session.session),
        // ),

        ChangeNotifierProxyProvider<SessionProvider, Users>(
          // create: (context) => Users(
          //     Provider.of<SessionProvider>(context, listen: false).session),
          create: (context) => Users(
            Session(
              id: '0',
              userId: '0',
              accessToken: 'abc',
              accessTokenExpiry: DateTime(2050),
              refreshToken: 'abc',
              refreshTokenExpiry: DateTime(2050),
            ),
          ),
          update: (context, session, previousUser) => Users(session.session),
        ),
        // ChangeNotifierProvider.value(value: Users()),
        ChangeNotifierProvider(create: (_) => Books()),
        ChangeNotifierProvider(create: (_) => Comments()),
        // ChangeNotifierProvider.value(value: AppDrawer()),
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
        // home: SplashScreen(),
        // home: OnBoardingScreen(),
        // home: AddPostScreen(),
        // home: LoginSignupScreen(),
        home: LoginScreen(),
        // home: SignUpScreen(),
        routes: {
          SinglePostScreen.routeName: (context) => SinglePostScreen(),
          UserPostsScreen.routeName: (context) => UserPostsScreen(),
          AddPostScreen.routeName: (context) => AddPostScreen(),
          EditPostScreen.routeName: (context) => EditPostScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          LoginSignupScreen.routeName: (context) => LoginSignupScreen(),
          UserProfileScreen.routeName: (context) => UserProfileScreen(),
        },
      ),
    );
  }
}
