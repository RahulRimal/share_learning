import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/screens/home_screen.dart';
import 'package:share_learning/templates/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
    // Navigator.pushReplacementNamed(context, Ob);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.network(
    //       'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
    // );
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.network(
            'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
      ),
    );
  }
}
