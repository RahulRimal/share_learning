class Book {
  final String id;
  final String title;
  final String description;
  final String author;
  final DateTime boughtTime;
  final double price;
  final bool isWishlisted;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.boughtTime,
    required this.price,
    required this.isWishlisted,
  });
}
