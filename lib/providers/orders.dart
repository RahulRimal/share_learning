import 'package:flutter/material.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/order.dart';
import 'package:share_learning/models/session.dart';

class Orders with ChangeNotifier {
  // List<Order> _myOrders = [];

  List<Order> _myOrders = [
    Order(
      id: '1',
      bookId: '1',
      sellingUserId: '1',
      buyingUserId: '2',
      bookCount: 2,
      pricePerPiece: 500,
      wishlisted: true,
      postType: "B",
    ),
    Order(
      id: '3',
      bookId: '1',
      sellingUserId: '2',
      buyingUserId: '5',
      bookCount: 1,
      pricePerPiece: 500,
      wishlisted: true,
      postType: "S",
    ),
    Order(
      id: '6',
      bookId: '3',
      sellingUserId: '1',
      buyingUserId: '5',
      bookCount: 1,
      pricePerPiece: 300,
      wishlisted: true,
      postType: "B",
    ),
  ];

  bool _loading = false;
  OrderError? _orderError;

  // final Session authenticatedSession;

  // orders(this.authenticatedSession);

  // orders() {
  //   getorders();
  // }

  bool get loading => _loading;

  List<Order> get orders {
    return [..._myOrders];
  }

  OrderError? get orderError => _orderError;

  // factory orders.fromJson(Map<String, dynamic> parsedJson) {
  //   return order(
  //     id: parsedJson['id'].toString(),postm
  //     userId: parsedJson['userId'].toString(),
  //     orderName: parsedJson['orderName'].toString(),
  //     description: parsedJson['description'].toString(),
  //     author: parsedJson['author'].toString(),
  //     boughtTime: NepaliDateTime.parse(parsedJson['boughtTime'].toString()),
  //     price: parsedJson['price'],
  //     orderCount: parsedJson['orderCount'],
  //     isWishlisted: parsedJson['isWishlisted'],
  //     selling: parsedJson['selling'],
  //   );
  // }

  setLoading(bool loading) async {
    _loading = loading;
    // notifyListeners();
  }

  setorders(List<Order> orders) {
    _myOrders = orders;
  }

  setorderError(OrderError orderError) {
    _orderError = orderError;
  }

  // getorders(Session loggedInSession) async {
  //   setLoading(true);

  //   // var response = await orderApi.getorders(uId);
  //   var response = await orderApi.getorders(loggedInSession);

  //   if (response is Success) {
  //     setorders(response.response as List<order>);
  //   }
  //   if (response is Failure) {
  //     orderError orderError = orderError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //     setorderError(orderError);
  //   }
  //   setLoading(false);
  // }

  // getordersAnnonimusly(Session loggedInSession) async {
  //   setLoading(true);

  //   var response = await orderApi.getAnnonimusPosts(loggedInSession);

  //   if (response is Success) {
  //     setorders(response.response as List<order>);
  //   }
  //   if (response is Failure) {
  //     orderError orderError = orderError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //     setorderError(orderError);
  //   }
  //   setLoading(false);
  // }

  Order getOrderById(String orderId) {
    return orders.firstWhere((order) => order.id == orderId);
  }

  // Future<Book> getBokById(String bookId) {}

  // List<Order> ordersByUser(String userId) {
  //   return orders.where((order) => order.buyingUserId == userId).toList();
  // }

  // bool hasPostByUser(String userId) {
  //   final userorder = orders.firstWhereOrNull((post) => post.userId == userId);

  //   if (userorder != null)
  //     return true;
  //   else
  //     return false;
  // }

  void addOrder(Order receivedInfo) {
    // order neworder = order(
    //   id: receivedInfo.id,
    //   userId: receivedInfo.userId,
    //   orderName: receivedInfo.orderName,
    //   author: receivedInfo.author,
    //   boughtDate: receivedInfo.boughtDate,
    //   description: receivedInfo.description,
    //   wishlisted: receivedInfo.wishlisted,
    //   price: receivedInfo.price,
    //   orderCount: receivedInfo.orderCount,
    //   postType: receivedInfo.postType,
    //   postedOn: receivedInfo.postedOn,
    //   postRating: receivedInfo.postRating,
    // );

    _myOrders.add(receivedInfo);
    notifyListeners();
  }

  void addOrders(List<Order> receivedInfo) {
    // for (order order in receivedInfo) {
    //   order neworder = order(
    //     id: order.id,
    //     userId: order.userId,
    //     orderName: order.orderName,
    //     author: order.author,
    //     boughtTime: order.boughtTime,
    //     description: order.description,
    //     isWishlisted: order.isWishlisted,
    //     price: order.price,
    //     orderCount: order.orderCount,
    //     selling: order.selling,
    //   );
    //   _myorders.add(neworder);
    // }

    _myOrders.addAll(receivedInfo);
    notifyListeners();
  }

  // void updatePost(String id, order edittedPost){

  //   final postIndex = _myorders.indexWhere((element) => element.id == id);

  //   _myorders[postIndex] = edittedPost;

  //   notifyListeners();
  // }

  // void createOrder(Session currentSession, Order receivedInfo) async {
  //   var response = await orderApi.createPost(currentSession, receivedInfo);

  //   if (response is Success) {
  //     addPost(response.response as order);
  //   }
  //   if (response is Failure) {
  //     orderError orderError = orderError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //     setorderError(orderError);
  //   }
  //   notifyListeners();
  // }

  // void updateOrder(Session currentSession, Order edittedOrder) async {
  //   var response = await orderApi.updatePost(currentSession, edittedPost);

  //   if (response is Success) {
  //     final postIndex =
  //         _myorders.indexWhere((element) => element.id == edittedPost.id);
  //     _myorders[postIndex] = response as order;
  //   }

  //   if (response is Failure) {
  //     orderError orderError = orderError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //     setorderError(orderError);
  //   }

  //   notifyListeners();
  // }

  // Future<bool> deleteOrder(Session currentSession, String postId) async {
  //   var response = await orderApi.deletePost(currentSession, postId);

  //   if (response is Success) {
  //     final postIndex = _myorders.indexWhere((element) => element.id == postId);
  //     _myorders.removeAt(postIndex);
  //     // notifyListeners();
  //     return true;
  //   }
  //   if (response is Failure) {
  //     orderError orderError = orderError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //     setorderError(orderError);
  //     // notifyListeners();
  //     return false;
  //   }
  //   notifyListeners();
  //   return false;
  // }

}
