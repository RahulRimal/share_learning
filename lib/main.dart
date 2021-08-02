import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/app-drawer.dart';

// import './widgets';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Your Learning',
      theme: ThemeData(
          primaryColor: Colors.redAccent, accentColor: Colors.blueAccent),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
