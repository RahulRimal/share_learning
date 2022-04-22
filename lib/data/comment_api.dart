import 'dart:convert';
import 'dart:io';

import 'package:share_learning/models/api_status.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/templates/managers/api_values_manager.dart';
import 'package:http/http.dart' as http;
import 'package:share_learning/templates/managers/strings_manager.dart';
import 'package:share_learning/templates/managers/values_manager.dart';

class CommentApi {
  static Future<Object> getPostComments(String postId) async {
    try {
      // var url = Uri.parse('http://localhost/apiforsharelearn/posts/u/1');
      // var url = Uri.parse('http://10.0.2.2/apiforsharelearn/posts/u/' + uId);
      var url = Uri.parse(RemoteManager.BASE_URI + '/replies/p/' + postId);

      var response = await http.get(
        url,
      );

      if (response.statusCode == ApiStatusCode.responseSuccess) {
        print(json.decode(response.body)['data']['replies']);
        return Success(
            code: response.statusCode,
            response: commentFromJson(
                json.encode(json.decode(response.body)['data']['replies'])));
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
