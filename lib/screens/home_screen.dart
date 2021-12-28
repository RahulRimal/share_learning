import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/app_drawer.dart';
import 'package:share_learning/widgets/post.dart';

class HomeScreen extends StatelessWidget {
  AsyncMemoizer memoizer = AsyncMemoizer();

  Books books = new Books();

  List<Book> booksToShow = [];

  Future<List<Book>?> getUserPosts(ctx) async {
    Future<dynamic> tempData = this.memoizer.runOnce(() async {
      try {
        // const url = 'http://localhost/ProjectShareBooks/';
        const url = 'http://localhost/apiforsharelearn/posts/u/1';
        final response = await http.get(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader:
              'MmJkMjU5MTM5NmNmNTkyNTdmMGEzY2EzOTExY2U2ZWE3YTU0ZDk3NDAxM2ZiMzViMzEzNjMzMzUzNzM3MzEzOTM1MzY='
        }
            // headers: {
            //     "Authorization":
            //         "MmJkMjU5MTM5NmNmNTkyNTdmMGEzY2EzOTExY2U2ZWE3YTU0ZDk3NDAxM2ZiMzViMzEzNjMzMzUzNzM3MzEzOTM1MzY=",
            //     "Accept": "application/json",
            //     "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            // "Access-Control-Allow-Methods": "POST, GET, OPTIONS"
            //   }

            );

        final responseData = json.decode(response.body);
        final responsePosts = responseData['data']['posts'];

        List<dynamic> receivedData =
            responsePosts.map((val) => Book.fromJson(val)).toList();

        List<Book> newBooks = [];
        for (var i = 0; i < receivedData.length; i++) {
          newBooks.add(receivedData[i]);
          booksToShow.add(receivedData[i]);
        }

        Provider.of<Books>(ctx, listen: false).addPosts(newBooks);

        return newBooks;
      } catch (e) {
        print(e);
      }
    });

    return booksToShow;
  }

  @override
  Widget build(BuildContext context) {
    List<Book> booksToRender = Provider.of<Books>(context).books;
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

      body: FutureBuilder(
        future: getUserPosts(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: booksToRender.length,
              itemBuilder: (context, index) => Post(
                id: booksToRender[index].id,
                title: booksToRender[index].title,
                description: booksToRender[index].description,
                author: booksToRender[index].author,
                boughtTime: booksToRender[index].boughtTime,
                price: booksToRender[index].price,
                bookCount: booksToRender[index].bookCount,
                selling: booksToRender[index].selling,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
