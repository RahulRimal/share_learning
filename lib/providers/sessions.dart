

// import 'package:flutter/material.dart';
// import 'package:share_learning/data/session_api.dart';
// import 'package:share_learning/models/session.dart';

// class Session with ChangeNotifier {

//   // List<Session> _sessions = [];
//   late Session _session;
//   bool _loading = false;

//   SessionError? _sessionError;

//   bool get loading => _loading;

//   Session get session =>_session;

//   SessionError? get SessionError => _sessionError;

//   setLoading(bool loading) async {
//     _loading = loading;
//     notifyListeners();
//   }

//   setSession(Session session) {
//     _session = session;
//   }

//   setSessionError(SessionError sessionError) {
//     _sessionError = sessionError;
//   }

//   getSession(String userName, String password) async {
//     setLoading(true);

//     var response = await SessionApi.postSession(userName, password);

//     if (response is Success) {
//       setBooks(response.response as List<Book>);
//     }
//     if (response is Failure) {
//       BookError bookError = BookError(
//         code: response.code,
//         message: response.errorResponse,
//       );
//       setBookError(bookError);
//     }
//     setLoading(false);
//   }

//   Book getBookById(String bookId) {
//     return books.firstWhere((book) => book.id == bookId);
//   }

//   List<Book> postsByUser(String userId) {
//     return books.where((book) => book.userId == userId).toList();
//   }

//   bool hasPostByUser(String userId) {
//     final userBook = books.firstWhereOrNull((post) => post.userId == userId);

//     if (userBook != null)
//       return true;
//     else
//       return false;
//   }

//   void addPost(Book receivedInfo) {
//     Book newBook = Book(
//       id: '4',
//       userId: receivedInfo.userId,
//       bookName: receivedInfo.bookName,
//       author: receivedInfo.author,
//       boughtDate: receivedInfo.boughtDate,
//       description: receivedInfo.description,
//       wishlisted: receivedInfo.wishlisted,
//       price: receivedInfo.price,
//       bookCount: receivedInfo.bookCount,
//       postType: receivedInfo.postType,
//       postedOn: receivedInfo.postedOn,
//       postRating: receivedInfo.postRating,
//     );

//     _myBooks.add(newBook);
//     notifyListeners();
//   }

//   void addPosts(List<Book> receivedInfo) {
//     // for (Book book in receivedInfo) {
//     //   Book newBook = Book(
//     //     id: book.id,
//     //     userId: book.userId,
//     //     bookName: book.bookName,
//     //     author: book.author,
//     //     boughtTime: book.boughtTime,
//     //     description: book.description,
//     //     isWishlisted: book.isWishlisted,
//     //     price: book.price,
//     //     bookCount: book.bookCount,
//     //     selling: book.selling,
//     //   );
//     //   _myBooks.add(newBook);
//     // }

//     _myBooks.addAll(receivedInfo);
//     notifyListeners();
//   }

//   void updatePost(String id, Book edittedPost) {
//     final postIndex = _myBooks.indexWhere((element) => element.id == id);

//     _myBooks[postIndex] = edittedPost;

//     notifyListeners();
//   }
// }
