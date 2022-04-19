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
  static Future<Object> getBooks(String uId) async {
    // static Future<Object> getBooks() async {
    try {
      // var url = Uri.parse('http://localhost/apiforsharelearn/posts/u/1');
      // var url = Uri.parse('http://10.0.2.2/apiforsharelearn/posts/u/' + uId);
      var url = Uri.parse(RemoteManager.BASE_URI + '/posts/u/' + uId);

      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader:
              'Mzk0YTM2ZWZhZGQ1ZjY2MDQwZmMxMWZkNGE4MzRjMmM2M2FhMTNhY2M1ZDhlYTEyMzEzNjM0MzIzOTM1MzAzMjM1MzA='
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
}
