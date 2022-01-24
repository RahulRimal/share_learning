import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_learning/models/api_status.dart';
import 'package:share_learning/models/book.dart';

class BookApi {
  static Future<Object> getBooks() async {
    try {
      var url = Uri.parse('http://localhost/apiforsharelearn/posts/u/1');

      var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader:
              'Mzk0YTM2ZWZhZGQ1ZjY2MDQwZmMxMWZkNGE4MzRjMmM2M2FhMTNhY2M1ZDhlYTEyMzEzNjM0MzIzOTM1MzAzMjM1MzA='
        },
      );

      print(json.encode(json.decode(response.body)['data']['posts']));

      if (response.statusCode == 200) {
        return Success(
            // code: response.statusCode, response: bookFromJson(response.body));
            code: response.statusCode,
            // response:
            //     bookFromJson(json.decode(response.body)['data']['posts']));
            response: bookFromJson(
                json.encode(json.decode(response.body)['data']['posts'])));
      }

      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: 102, errorResponse: 'Invalid Format');
    } catch (e) {
      // return Failure(code: 103, errorResponse: e.toString());
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }
}
