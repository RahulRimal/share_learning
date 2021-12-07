import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/app_drawer.dart';
import 'package:share_learning/widgets/post.dart';

class HomeScreen extends StatelessWidget {
  Future<List<dynamic>?> getUserPosts() async {
    try {
      // const url = 'http://localhost/ProjectShareBooks/';
      const url = 'http://localhost/apiforsharelearn/posts/u/1';
      final response = await http.get(Uri.parse(url),
      headers: {
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
      // print(json.decode(response.body));
      final responseData = json.decode(response.body);
      final responsePosts = responseData['data']['posts'];
      print(responsePosts);
      return responsePosts;
    } catch (e) {
      print(e);
    }
  }
  // Future<List<Post>> getPostsList() async {
  // Future<void> getPostsList() async {
  //   // const url = 'http://localhost/ProjectShareBooks/';
  //   const url = 'http://localhost/ProjectShareBooks/posts/u/1';
  //   final response = await http.get(Uri.parse(url), headers: {
  //     //  'Content-Type': 'application/json',
  //     // 'Accept': 'application/json',
  //     'Access-Control_Allow_Origin': '*',
  //     'Authorization':
  //         'MmJkMjU5MTM5NmNmNTkyNTdmMGEzY2EzOTExY2U2ZWE3YTU0ZDk3NDAxM2ZiMzViMzEzNjMzMzUzNzM3MzEzOTM1MzY=',
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Book> booksToRender = Provider.of<Books>(context).books;
    Future<List<dynamic>?> userPosts = getUserPosts();
    // getUserPosts();
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
      body: ListView.builder(
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
      ),
    );
  }
}
