import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:share_learning/templates/widgets/order_item.dart';

List<Order> OrderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String OrderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.bookId,
    required this.sellingUserId,
    required this.buyingUserId,
    required this.bookCount,
    required this.pricePerPiece,
    // required this.totalPrice,
    required this.wishlisted,
    required this.postType,
    // required this.postedOn,
  });

  String id;
  String bookId;
  // String postingUserId;
  // String orderingUserId;
  String sellingUserId;
  String buyingUserId;
  double pricePerPiece;
  // double totalPrice;
  int bookCount;
  bool wishlisted;
  String postType;
  // DateTime postedOn;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        bookId: json["bookId"] == null ? null : json["bookId"],
        sellingUserId:
            json["sellingUserId"] == null ? null : json["sellingUserId"],
        buyingUserId:
            json["buyingUserId"] == null ? null : json["buyingUserId"],
        pricePerPiece:
            json["pricePerPiece"] == null ? null : json["pricePerPiece"],
        // boughtDate: json["boughtDate"] == null
        //     ? null
        //     : DateTime.parse(json["boughtDate"]),
        // boughtDate: NepaliDateTime.parse(json["boughtDate"].toString()),
        // totalPrice: json["price"] == null ? null : json["price"].toDouble(),
        // bookCount: json["bookCount"] == null ? null : int.parse(json["bookCount"]),
        bookCount: int.parse(json["bookCount"]),
        // wishlisted: json["wishlisted"] == null ? null : json["wishlisted"],
        wishlisted: json["wishlisted"] == '1' ? true : false,
        postType: json["postType"] == null ? null : json["postType"],
        // postedOn:
        //     json["postedOn"] == null ? null : DateTime.parse(json["postedOn"]),
        // postedOn: NepaliDateTime.parse(json["postedOn"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "bookId": bookId == null ? null : bookId,
        "sellingUserId": sellingUserId == null ? null : sellingUserId,
        "buyingUserId": buyingUserId == null ? null : buyingUserId,
        "pricePerPiece": pricePerPiece == null ? null : pricePerPiece,
        "bookCount": bookCount == null ? null : bookCount,
        "wishlisted": wishlisted == null ? null : wishlisted,
        "postType": postType == null ? null : postType,
      };
}

class OrderError {
  int code;
  Object message;

  OrderError({required this.code, required this.message});
}
