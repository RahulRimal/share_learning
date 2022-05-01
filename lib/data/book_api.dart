import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_learning/models/api_status.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/templates/managers/api_values_manager.dart';
import 'package:share_learning/templates/managers/strings_manager.dart';
import 'package:share_learning/templates/managers/values_manager.dart';

class BookApi {
  // static Future<Object> getBooks(Session loggedInUser, String uId) async {
  static Future<Object> getBooks(Session loggedInUser) async {
    try {
      var url =
          Uri.parse(RemoteManager.BASE_URI + '/posts/u/' + loggedInUser.userId);

      var response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: loggedInUser.accessToken},
      );

      if (response.statusCode == ApiStatusCode.responseSuccess) {
        return Success(
            code: response.statusCode,
            response: bookFromJson(
                json.encode(json.decode(response.body)['data']['posts'])));
      }

      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidResponseString,
      );
    } on HttpException {
      return Failure(
        code: ApiStatusCode.httpError,
        errorResponse: ApiStrings.noInternetString,
      );
    } on FormatException {
      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidFormatString,
      );
    } catch (e) {
      // return Failure(code: 103, errorResponse: e.toString());
      return Failure(
        code: ApiStatusCode.unknownError,
        errorResponse: ApiStrings.unknownErrorString,
      );
    }
  }

  static Future<Object> getAnnonimusPosts(Session loggedInUser) async {
    try {
      var url = Uri.parse(RemoteManager.BASE_URI + '/posts');

      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: loggedInUser.accessToken,
        },
      );

      if (response.statusCode == ApiStatusCode.responseSuccess) {
        return Success(
            code: response.statusCode,
            response: bookFromJson(
                json.encode(json.decode(response.body)['data']['posts'])));
      }

      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidResponseString,
      );
    } on HttpException {
      return Failure(
        code: ApiStatusCode.httpError,
        errorResponse: ApiStrings.noInternetString,
      );
    } on FormatException {
      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidFormatString,
      );
    } catch (e) {
      // return Failure(code: 103, errorResponse: e.toString());
      return Failure(
        code: ApiStatusCode.unknownError,
        errorResponse: ApiStrings.unknownErrorString,
      );
    }
  }

  static Future<Object> updatePost(
      Session currentSession, Book updatedPost) async {
    try {
      Map<String, String> postBody = {
        "userId": updatedPost.userId,
        "bookName": updatedPost.bookName,
        "author": updatedPost.author,
        "description": updatedPost.description,
        "boughtDate": updatedPost.boughtDate.toIso8601String(),
        "price": updatedPost.price.toString(),
        "bookCount": updatedPost.bookCount.toString(),
        "wishlisted": updatedPost.wishlisted.toString(),
        "postType": updatedPost.postType,
        "postRating": updatedPost.postRating,
        // "postedOn": updatedPost.postedOn.toIso8601String()
      };
      var url =
          Uri.parse(RemoteManager.BASE_URI + '/posts/p/' + updatedPost.id);

      var response = await http.patch(
        url,
        headers: {
          HttpHeaders.authorizationHeader: currentSession.accessToken,
          "Accept": "application/json; charset=utf-8",
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode(postBody),
      );

      if (response.statusCode == ApiStatusCode.responseSuccess) {
        return Success(
            code: response.statusCode,
            response: sessionFromJson(json
                .encode(json.decode(response.body)['data']['sessions'][0])));
      }
      return Failure(
          code: ApiStatusCode.invalidResponse,
          errorResponse: ApiStrings.invalidResponseString);
    } on HttpException {
      return Failure(
          code: ApiStatusCode.httpError,
          errorResponse: ApiStrings.noInternetString);
    } on FormatException {
      return Failure(
          code: ApiStatusCode.invalidResponse,
          errorResponse: ApiStrings.invalidFormatString);
    } catch (e) {
      // return Failure(code: 103, errorResponse: e.toString());
      return Failure(
          code: ApiStatusCode.unknownError,
          errorResponse: ApiStrings.unknownErrorString);
    }
  }
}
