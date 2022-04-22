import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/users.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/font_manager.dart';
import 'package:share_learning/templates/managers/style_manager.dart';
import 'package:share_learning/templates/widgets/app_drawer.dart';
import 'package:share_learning/templates/widgets/post.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AsyncMemoizer memoizer = AsyncMemoizer();

  User user = new User(
      id: "0",
      firstName: 'firstName',
      lastName: 'lastName',
      username: 'username',
      email: 'email',
      description: 'description',
      userClass: 'userClass',
      followers: 'followers',
      createdDate: DateTime.now());

  _setUserValue(User user) {
    user = user;
  }

  @override
  Widget build(BuildContext context) {
    // List<Book> booksToRender = Provider.of<Books>(context).books;

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Session authenticatedSession = args['authSession'] as Session;

    // Users users = context.watch<Users>();
    Books books = context.watch<Books>();

    // User _user = users.getUserByToken(authenticatedSession.accessToken);

    // Provider.of<Books>(context, listen: false)
    //     .getBooks(authenticatedSession.userId);

    // List<Book> booksToRender = Provider.of<Books>(context).books;

    // User user;

    // Future.delayed(Duration(seconds: 1), () {
    //   user = users.user;
    //   _setUserValue(user);
    // });

    // User user = users.user;

    return Scaffold(
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
      body: Container(
        child: Container(
          child: FutureBuilder(
            future: books.getBooks(authenticatedSession.userId),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else {
                  return Consumer<Books>(
                    builder: (ctx, books, child) {
                      return books.books.length <= 0
                          ? Center(
                              child: Text(
                                'No books found',
                                style: getBoldStyle(
                                    fontSize: FontSize.s20,
                                    color: ColorManager.primary),
                              ),
                            )
                          : ListView.builder(
                              itemCount: books.books.length,
                              itemBuilder: (ctx, index) {
                                return Post(
                                  loggedInUserSession: authenticatedSession,
                                  id: books.books[index].id,
                                  title: books.books[index].bookName,
                                  description: books.books[index].description,
                                  author: books.books[index].author,
                                  boughtTime: books.books[index].boughtDate,
                                  price: books.books[index].price,
                                  selling: books.books[index].postType == 'S'
                                      ? true
                                      : false,
                                  bookCount: books.books[index].bookCount,
                                );
                              },
                            );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
      drawer: AppDrawer(authenticatedSession.accessToken),
    );
  }
}
