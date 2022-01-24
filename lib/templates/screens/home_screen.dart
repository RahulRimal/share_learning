import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/templates/widgets/app_drawer.dart';
import 'package:share_learning/templates/widgets/post.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  // AsyncMemoizer memoizer = AsyncMemoizer();
  // Books books = new Books();
  // List<Book> booksToShow = [];

  // Future<List<Book>?> getUserPosts(ctx) async {
  //   Future<dynamic> tempData = this.memoizer.runOnce(() async {
  //     try {
  //       // const url = 'http://localhost/ProjectShareBooks/';
  //       const url = 'http://localhost/apiforsharelearn/posts/u/1';
  //       final response = await http.get(Uri.parse(url), headers: {
  //         HttpHeaders.authorizationHeader:
  //             'Mzk0YTM2ZWZhZGQ1ZjY2MDQwZmMxMWZkNGE4MzRjMmM2M2FhMTNhY2M1ZDhlYTEyMzEzNjM0MzIzOTM1MzAzMjM1MzA='
  //       }
  //           // headers: {
  //           //     "Authorization":
  //           //         "MmJkMjU5MTM5NmNmNTkyNTdmMGEzY2EzOTExY2U2ZWE3YTU0ZDk3NDAxM2ZiMzViMzEzNjMzMzUzNzM3MzEzOTM1MzY=",
  //           //     "Accept": "application/json",
  //           //     "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  //           // "Access-Control-Allow-Methods": "POST, GET, OPTIONS"
  //           //   }
  //           );
  //       final responseData = json.decode(response.body);
  //       final responsePosts = responseData['data']['posts'];
  //       print(responseData);
  //       List<dynamic> receivedData =
  //           responsePosts.map((val) => Book.fromJson(val)).toList();
  //       List<Book> newBooks = [];
  //       for (var i = 0; i < receivedData.length; i++) {
  //         newBooks.add(receivedData[i]);
  //         booksToShow.add(receivedData[i]);
  //       }
  //       Provider.of<Books>(ctx, listen: false).addPosts(newBooks);
  //       return newBooks;
  //     } catch (e) {
  //       print(e);
  //     }
  //   });
  //   return booksToShow;
  // }

  _homeUI(Books books) {
    if (books.loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (books.bookError != null) {
      return Container(
        child: Center(
          child: Text('Book Error'),
          // child: Text(
          //   books.bookError.message.toString(),
          // ),
        ),
      );
    }

    return ListView.builder(
      itemCount: books.books.length,
      itemBuilder: (context, index) => Post(
        id: books.books[index].id,
        title: books.books[index].bookName,
        description: books.books[index].description,
        author: books.books[index].author,
        boughtTime: books.books[index].boughtDate,
        price: books.books[index].price,
        selling: books.books[index].postType == 'S' ? true : false,
        bookCount: books.books[index].bookCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List<Book> booksToRender = Provider.of<Books>(context).books;
    Books books = context.watch<Books>();
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
      // body: ListView.builder(
      //   itemCount: Books().books.length,
      //   itemBuilder: (context, index) => Post(
      //     id: Books().books[index].id,
      //     title: Books().books[index].title,
      //     description: Books().books[index].description,
      //     author: Books().books[index].author,
      //     boughtTime: Books().books[index].boughtTime,
      //     price: Books().books[index].price,
      //     selling: Books().books[index].selling,
      //   ),
      // ),
      // body: ListView.builder(
      //   itemCount: booksToRender.length,
      //   itemBuilder: (context, index) => Post(
      //     id: booksToRender[index].id,
      //     title: booksToRender[index].title,
      //     description: booksToRender[index].description,
      //     author: booksToRender[index].author,
      //     boughtTime: booksToRender[index].boughtTime,
      //     price: booksToRender[index].price,
      //     bookCount: booksToRender[index].bookCount,
      //     selling: booksToRender[index].selling,
      //   ),
      // ),

      // body: FutureBuilder(
      //   future: getUserPosts(context),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: booksToRender.length,
      //         itemBuilder: (context, index) => Post(
      //           id: booksToRender[index].id,
      //           title: booksToRender[index].bookName,
      //           description: booksToRender[index].description,
      //           author: booksToRender[index].author,
      //           boughtTime: booksToRender[index].boughtDate,
      //           price: booksToRender[index].price,
      //           bookCount: booksToRender[index].bookCount,
      //           selling: booksToRender[index].postType == 'S' ? true : false,
      //         ),
      //       );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

      body: Container(
        child: _homeUI(books),
      ),
    );
  }
}
