import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_learning/models/api_status.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/templates/managers/api_values_manager.dart';
import 'package:share_learning/templates/managers/strings_manager.dart';
import 'package:share_learning/templates/managers/values_manager.dart';

class SessionApi {
  static Future<Object> getPreviousSession(String accessToken) async {
    try {
      var url = Uri.parse(RemoteManager.BASE_URI + '/sessions');

      var response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: accessToken},
      );
      if (response.statusCode == ApiStatusCode.responseSuccess) {
        return Success(
            code: response.statusCode,
            response: sessionFromJson(
                json.encode(json.decode(response.body)['data']['session'])));
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

  static Future<Object> postSession(String userName, String password) async {
    try {
      Map<String, String> postBody = {
        "username": userName,
        "password": password
      };
      // var url = Uri.parse('http://localhost/apiforsharelearn/sessions');
      var url = Uri.parse(RemoteManager.BASE_URI + '/sessions');

      // Map<String, String> postHeaders = {
      // "Content-Type": "application/json; charset=utf-8",
      // "Content-Type": "application/json",
      // HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
      // HttpHeaders.contentTypeHeader: "application/json",
      // };

      var response = await http.post(
        url,
        // headers: postHeaders,
        headers: {
          // HttpHeaders.authorizationHeader:
          //     'Mzk0YTM2ZWZhZGQ1ZjY2MDQwZmMxMWZkNGE4MzRjMmM2M2FhMTNhY2M1ZDhlYTEyMzEzNjM0MzIzOTM1MzAzMjM1MzA=',
          // "Accept": "application/json",
          "Accept": "application/json; charset=utf-8",
          // "Accept": "application/json; charset=UTF-8",
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
          // "Content-Type": "application/json; charset=utf-8",
          // "Content-Type": "application/json; charset=utf-8",
          // "Content-Type": "application/json",
          // HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        },
        body: json.encode(postBody),
        // body: postBody,
      );

      // print(json.encode(json.decode(response.body)['data']['sessions']));
      // print(response.body);
      // print(json.encode(json.decode(response.body)['data']['sessions'][0]));
      if (response.statusCode == ApiStatusCode.responseCreated) {
        return Success(
            code: response.statusCode,
            response: sessionFromJson(json
                .encode(json.decode(response.body)['data']['sessions'][0])));
      }
      return Failure(
          code: ApiStatusCode.invalidResponse,
          // errorResponse: ApiStrings.invalidResponseString
          errorResponse: response.body);
    } on HttpException {
      return Failure(
          code: ApiStatusCode.httpError,
          errorResponse: ApiStrings.noInternetString);
    } on FormatException {
      return Failure(
          code: ApiStatusCode.invalidResponse,
          errorResponse: ApiStrings.invalidFormatString);
    } catch (e) {
      return Failure(code: 103, errorResponse: e.toString());
      // return Failure(
      //     code: ApiStatusCode.unknownError,
      //     errorResponse: ApiStrings.unknownErrorString);
    }
  }

  static Future<Object> deleteSession(String sessionId) async {
    try {
      var url = Uri.parse(RemoteManager.BASE_URI + '/sessions/' + sessionId);

      var response = await http.delete(
        url,
        headers: {
          "Accept": "application/json; charset=utf-8",

          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, DELETE",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      if (response.statusCode == ApiStatusCode.responseSuccess) {
        // print(response.body);
        return Success(
          code: response.statusCode,
          response: response.body,
        );
      }
      return Failure(
          code: ApiStatusCode.invalidResponse,
          errorResponse: ApiStrings.invalidResponseString
          // errorResponse: response.body
          );
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
        errorResponse: ApiStrings.unknownErrorString,
      );
    }
  }
}
