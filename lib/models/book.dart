import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart';

class Book {
  late final String id;
  final String uId;
  final String title;
  final String description;
  final String author;
  // final DateTime boughtTime;
  final NepaliDateTime boughtTime;
  final double price;
  final int bookCount;
  final bool isWishlisted;
  final bool selling;
  List<String>? pictures;

  Book({
    required this.id,
    required this.uId,
    required this.title,
    required this.description,
    required this.author,
    required this.boughtTime,
    required this.price,
    required this.bookCount,
    required this.isWishlisted,
    required this.selling,
    this.pictures,
  });

  factory Book.fromJson(Map<String, dynamic> parsedJson) {
    return Book(
      id: parsedJson['id'].toString(),
      uId: parsedJson['userId'].toString(),
      title: parsedJson['bookName'].toString(),
      description: parsedJson['description'].toString(),
      author: parsedJson['author'].toString(),
      // boughtTime: NepaliDateTime.parse(parsedJson['boughtTime'].toString()),
      // boughtTime: NepaliDateTime.parse(parsedJson['boughtTime'].toString()),
      //  ('yyyy-MM-dd').format(parsedJson['boughtTime'] as DateTime).toString();
      // boughtTime: NepaliDateTime.fromDateTime(
      //     DateTime.parse(parsedJson['boughtTime'].toString())),

      boughtTime: NepaliDateTime.parse(parsedJson['boughtDate'].toString()),

      price: parsedJson['price'],
      bookCount: parsedJson['bookCount'],
      isWishlisted:
          parsedJson['isWishlisted'].toString() == 'true' ? true : false,
      selling: parsedJson['selling'].toString() == 'S' ? true : false,
    );
  }
}
