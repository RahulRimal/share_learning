// import 'package:intl/intl.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart';
// // import 'package:nepali_date_picker/nepali_date_picker.dart';

// class Book {
//   late final String id;
//   final String uId;
//   final String title;
//   final String description;
//   final String author;
//   // final DateTime boughtTime;
//   final NepaliDateTime boughtTime;
//   final double price;
//   final int bookCount;
//   final bool isWishlisted;
//   final bool selling;
//   List<String>? pictures;

//   Book({
//     required this.id,
//     required this.uId,
//     required this.title,
//     required this.description,
//     required this.author,
//     required this.boughtTime,
//     required this.price,
//     required this.bookCount,
//     required this.isWishlisted,
//     required this.selling,
//     this.pictures,
//   });

//   factory Book.fromJson(Map<String, dynamic> parsedJson) {
//     return Book(
//       id: parsedJson['id'].toString(),
//       uId: parsedJson['userId'].toString(),
//       title: parsedJson['bookName'].toString(),
//       description: parsedJson['description'].toString(),
//       author: parsedJson['author'].toString(),
//       // boughtTime: NepaliDateTime.parse(parsedJson['boughtTime'].toString()),
//       // boughtTime: NepaliDateTime.parse(parsedJson['boughtTime'].toString()),
//       //  ('yyyy-MM-dd').format(parsedJson['boughtTime'] as DateTime).toString();
//       // boughtTime: NepaliDateTime.fromDateTime(
//       //     DateTime.parse(parsedJson['boughtTime'].toString())),
//       boughtTime: NepaliDateTime.parse(parsedJson['boughtDate'].toString()),
//       price: parsedJson['price'],
//       bookCount: int.parse(parsedJson['bookCount']),
//       isWishlisted:
//           parsedJson['isWishlisted'].toString() == 'true' ? true : false,
//       selling: parsedJson['selling'].toString() == 'S' ? true : false,
//     );
//   }
// }

// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.id,
    required this.userId,
    required this.bookName,
    required this.author,
    required this.description,
    required this.boughtDate,
    required this.price,
    required this.bookCount,
    required this.wishlisted,
    required this.postType,
    required this.postRating,
    required this.postedOn,
    this.pictures,
  });

  String id;
  String userId;
  String bookName;
  String author;
  String description;
  NepaliDateTime boughtDate;
  double price;
  int bookCount;
  bool wishlisted;
  String postType;
  String postRating;
  DateTime postedOn;
  List<String>? pictures;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        bookName: json["bookName"] == null ? null : json["bookName"],
        author: json["author"] == null ? null : json["author"],
        description: json["description"] == null ? null : json["description"],
        // boughtDate: json["boughtDate"] == null
        //     ? null
        //     : DateTime.parse(json["boughtDate"]),
        boughtDate: NepaliDateTime.parse(json["boughtDate"].toString()),
        price: json["price"] == null ? null : json["price"],
        // bookCount: json["bookCount"] == null ? null : int.parse(json["bookCount"]),
        bookCount: int.parse(json["bookCount"]),
        // wishlisted: json["wishlisted"] == null ? null : json["wishlisted"],
        wishlisted: json["wishlisted"] == '1' ? true : false,
        postType: json["postType"] == null ? null : json["postType"],
        postRating: json["postRating"] == null ? null : json["postRating"],
        // postedOn:
        //     json["postedOn"] == null ? null : DateTime.parse(json["postedOn"]),
        postedOn: NepaliDateTime.parse(json["postedOn"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "bookName": bookName == null ? null : bookName,
        "author": author == null ? null : author,
        "description": description == null ? null : description,
        "boughtDate": boughtDate == null
            ? null
            : "${boughtDate.year.toString().padLeft(4, '0')}-${boughtDate.month.toString().padLeft(2, '0')}-${boughtDate.day.toString().padLeft(2, '0')}",
        "price": price == null ? null : price,
        "bookCount": bookCount == null ? null : bookCount,
        "wishlisted": wishlisted == null ? null : wishlisted,
        "postType": postType == null ? null : postType,
        "postRating": postRating == null ? null : postRating,
        "postedOn": postedOn == null ? null : postedOn.toIso8601String(),
      };
}

class BookError {
  int code;
  Object message;

  BookError({required this.code, required this.message});
}
