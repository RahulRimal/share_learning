import 'package:flutter/foundation.dart';
import '../models/book.dart';

class Books with ChangeNotifier {
  List<Book> _myBooks = [
    Book(
        id: '0',
        title: 'C Programming Fundamentals II Edition',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        author: 'Rahul Rimal',
        boughtTime: DateTime.now(),
        price: 299,
        isWishlisted: true),
    Book(
        id: '1',
        title: 'Data Structures and Algorithms Revised Edition',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        author: 'Rahul Rimal',
        boughtTime: DateTime.now(),
        price: 100,
        isWishlisted: false),
    Book(
        id: '2',
        title: 'Mathematics II',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        author: 'Surendra Jha',
        boughtTime: DateTime.now(),
        price: 1000,
        isWishlisted: false),
    Book(
        id: '2',
        title: 'Computer Networking',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        author: 'Krishna Pd. Rimal',
        boughtTime: DateTime.now(),
        price: 800,
        isWishlisted: true),
  ];

  List<Book> get books {
    return [..._myBooks];
  }
}
