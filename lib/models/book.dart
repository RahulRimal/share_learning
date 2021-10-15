import 'package:nepali_date_picker/nepali_date_picker.dart';

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
}
