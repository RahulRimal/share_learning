import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

// class Comment {
//   late String id;
//   final String accessToken;
//   final String uId;
//   final String postId;
//   final String commentBody;

//   Comment({
//     required this.accessToken,
//     required this.uId,
//     required this.postId,
//     required this.commentBody,
//   });
// }

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.id,
    // required this.accessToken,
    required this.userId,
    required this.postId,
    required this.commentBody,
    required this.createdDate,
  });

  // String accessToken;
  String id;
  String userId;
  String postId;
  String commentBody;
  NepaliDateTime createdDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        postId: json["postId"] == null ? null : json["postId"],
        commentBody: json["commentBody"] == null ? null : json["commentBody"],
        createdDate: NepaliDateTime.parse(json["createdDate"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "postId": postId == null ? null : postId,
        "commentBody": commentBody == null ? null : commentBody,
        "createdDate":
            createdDate == null ? null : createdDate.toIso8601String(),

        // "boughtDate": boughtDate == null
        //     ? null
        //     : "${boughtDate.year.toString().padLeft(4, '0')}-${boughtDate.month.toString().padLeft(2, '0')}-${boughtDate.day.toString().padLeft(2, '0')}",
      };
}

class CommentError {
  int code;
  Object message;

  CommentError({required this.code, required this.message});
}

class Comments with ChangeNotifier {
  List<Comment> _comments = [
    Comment(
      // accessToken:
      //     'MzZiMTYwNGQzMGVhZDMzZmRmMzg3NDA5OTUyNzU5MTE0MWRiM2I0NWUzNmI3Y2ZlMzEzNjM1MzAzMzMzMzUzMTMzMzc',
      id: '1',
      userId: '0',
      postId: '1',
      commentBody:
          'Test 1 Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdDate: NepaliDateTime.now(),
    ),
    Comment(
      // accessToken:
      //     'MzZiMTYwNGQzMGVhZDMzZmRmMzg3NDA5OTUyNzU5MTE0MWRiM2I0NWUzNmI3Y2ZlMzEzNjM1MzAzMzMzMzUzMTMzMzc',
      id: '2',
      userId: '0',
      postId: '1',
      commentBody:
          'Test 2 Lorem ipsum dolor sit amejkldjflkdfjldfjjipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdDate: NepaliDateTime.now(),
    ),
    Comment(
      // accessToken:
      //     'MzZiMTYwNGQzMGVhZDMzZmRmMzg3NDA5OTUyNzU5MTE0MWRiM2I0NWUzNmI3Y2ZlMzEzNjM1MzAzMzMzMzUzMTMzMzc',
      id: '3',
      userId: '2',
      postId: '0',
      commentBody:
          'Test 3 consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdDate: NepaliDateTime.now(),
    ),
  ];

  List<Comment> get comments {
    return [..._comments];
  }

  List<Comment> getPostComments(String postId) {
    return comments.where((comment) => comment.postId == postId).toList();
  }
}
