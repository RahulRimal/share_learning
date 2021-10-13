import 'package:flutter/foundation.dart';
import '../models/book.dart';
import 'package:collection/collection.dart';

class Books with ChangeNotifier {
  List<Book> _myBooks = [
    Book(
      id: '0',
      uId: '0',
      title: 'C Programming Fundamentals II Edition',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      author: 'Rahul Rimal',
      boughtTime: DateTime.now(),
      price: 299,
      isWishlisted: true,
      selling: true,
      pictures: [
        'https://cdn.pixabay.com/photo/2021/08/16/19/24/boat-6551183_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
        'https://cdn.pixabay.com/photo/2021/08/10/18/32/cat-6536684__340.jpg',
        'https://cdn.pixabay.com/photo/2021/06/25/17/51/ladybug-6364312__340.jpg',
      ],
    ),
    Book(
      id: '1',
      uId: '0',
      title: 'Data Structures and Algorithms Revised Edition',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      author: 'Rahul Rimal',
      boughtTime: DateTime.now(),
      price: 100,
      isWishlisted: false,
      selling: false,
    ),
    Book(
      id: '2',
      uId: '1',
      title: 'Mathematics II',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      author: 'Surendra Jha',
      boughtTime: DateTime.now(),
      price: 1000,
      isWishlisted: false,
      selling: false,
      pictures: [
        'https://cdn.pixabay.com/photo/2021/08/16/19/24/boat-6551183_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
        'https://cdn.pixabay.com/photo/2021/08/10/18/32/cat-6536684__340.jpg',
        'https://cdn.pixabay.com/photo/2021/06/25/17/51/ladybug-6364312__340.jpg',
      ],
    ),
    Book(
      id: '3',
      uId: '1',
      title: 'Computer Networking',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      author: 'Krishna Pd. Rimal',
      boughtTime: DateTime.now(),
      price: 800,
      isWishlisted: true,
      selling: true,
      pictures: [
        'https://cdn.pixabay.com/photo/2021/08/16/19/24/boat-6551183_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
        'https://cdn.pixabay.com/photo/2021/08/10/18/32/cat-6536684__340.jpg',
        'https://cdn.pixabay.com/photo/2021/06/25/17/51/ladybug-6364312__340.jpg',
      ],
    ),
  ];

  List<Book> get books {
    return [..._myBooks];
  }

  Book getBookById(String bookId) {
    return books.firstWhere((book) => book.id == bookId);
  }

  List<Book> postsByUser(String uId) {
    return books.where((book) => book.uId == uId).toList();
  }

  bool hasPostByUser(String uId) {
    final userBook = books.firstWhereOrNull((post) => post.uId == uId);

    if (userBook != null)
      return true;
    else
      return false;
  }

  void addPost(Book receivedInfo) {
    Book newBook = Book(
      id: '4',
      uId: receivedInfo.uId,
      title: receivedInfo.title,
      author: receivedInfo.author,
      boughtTime: receivedInfo.boughtTime,
      description: receivedInfo.description,
      isWishlisted: receivedInfo.isWishlisted,
      price: receivedInfo.price,
      selling: receivedInfo.selling,
    );

    books.add(newBook);
    notifyListeners();
  }
}
