// import 'dart:io';
// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:share_learning/models/api_status.dart';
// import 'package:share_learning/models/book.dart';
// import 'package:share_learning/templates/managers/strings_manager.dart';
// import 'package:share_learning/templates/managers/values_manager.dart';

// class SessionApi {
//   static Future<Object> postSession(String userName, String password) async {
//     try {
//       Map<String, String> postBody = new Map<String, String>();
//       var url = Uri.parse('http://localhost/apiforsharelearn/sessions');

//       var response = await http.post(
//         url,
//         headers: {
//           HttpHeaders.authorizationHeader:
//               'Mzk0YTM2ZWZhZGQ1ZjY2MDQwZmMxMWZkNGE4MzRjMmM2M2FhMTNhY2M1ZDhlYTEyMzEzNjM0MzIzOTM1MzAzMjM1MzA='
//         },
//         body: 
//       );

//       print(json.encode(json.decode(response.body)['data']['sessions']));

//       if (response.statusCode == ApiStatusCode.responseSuccess) {
//         return Success(
//             code: response.statusCode,
//             // response:
//             //     bookFromJson(json.decode(response.body)['data']['posts']));
//             response: bookFromJson(
//                 json.encode(json.decode(response.body)['data']['sessions'])));
//       }

//       return Failure(
//           code: ApiStatusCode.invalidResponse,
//           errorResponse: ApiStrings.invalidResponseString);
//     } on HttpException {
//       return Failure(
//           code: ApiStatusCode.httpError,
//           errorResponse: ApiStrings.noInternetString);
//     } on FormatException {
//       return Failure(
//           code: ApiStatusCode.invalidResponse,
//           errorResponse: ApiStrings.invalidFormatString);
//     } catch (e) {
//       // return Failure(code: 103, errorResponse: e.toString());
//       return Failure(
//           code: ApiStatusCode.unknownError,
//           errorResponse: ApiStrings.unknownErrorString);
//     }
//   }
// }
