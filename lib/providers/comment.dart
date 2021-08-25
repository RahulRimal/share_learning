
import 'package:flutter/material.dart';

class Comment {
  late String id;
  final String uId;
  final String postId;
  final String commentBody;

  Comment({
    required this.uId,
    required this.postId,
    required this.commentBody,
  });
}

class Comments with ChangeNotifier {
  List<Comment> _comments = [
    Comment(
      uId: '0',
      postId: '0',
      commentBody:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),

    Comment(
      uId: '0',
      postId: '1',
      commentBody:
          'Lorem ipsum dolor sit amejkldjflkdfjldfjjipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),

    Comment(
      uId: '2',
      postId: '0',
      commentBody:
          'consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];

  List<Comment> get comments
  {
    return [..._comments];
  }


  List<Comment> getPostComments(String postId)
  {
    return comments.where((comment) => comment.postId == postId).toList();
  }




}
