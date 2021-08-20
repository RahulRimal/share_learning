import 'package:flutter/material.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/app_drawer.dart';
import 'package:share_learning/widgets/post.dart';

class HomeScreen extends StatelessWidget {
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
      body: ListView.builder(
        itemCount: Books().books.length,
        itemBuilder: (context, index) => Post(
          id: Books().books[index].id,
          title: Books().books[index].title,
          description: Books().books[index].description,
          author: Books().books[index].author,
          boughtTime: Books().books[index].boughtTime,
          price: Books().books[index].price,
          selling: Books().books[index].selling,
        ),
      ),
    );
  }
}
