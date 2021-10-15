import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/app_drawer.dart';
import 'package:share_learning/widgets/post.dart';

class UserPostsScreen extends StatelessWidget {
  static const routeName = '/user-posts';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final String userId = args['uId'];

    List<Book> _allPosts = Provider.of<Books>(context).postsByUser(userId);

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
      body: _allPosts.isNotEmpty
          ? ListView.builder(
              itemCount: _allPosts.length,
              itemBuilder: (context, index) => Post(
                id: _allPosts[index].id,
                title: _allPosts[index].title,
                description: _allPosts[index].description,
                author: _allPosts[index].author,
                boughtTime: _allPosts[index].boughtTime,
                price: _allPosts[index].price,
                bookCount: _allPosts[index].bookCount,
                selling: _allPosts[index].selling,
              ),
            )
          : Center(
              child: Text(
                'No Posts yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
