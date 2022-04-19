// class User {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String userName;
//   final String password;
//   final String image;

//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.userName,
//     required this.password,
//     required this.image,
//   });
// }

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.description,
      required this.userClass,
      required this.followers,
      required this.createdDate,
      this.image});

  String id;
  String firstName;
  String lastName;
  String username;
  String email;
  String description;
  String? image;
  String userClass;
  String followers;
  DateTime createdDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["name"] == null ? null : json["name"],
        lastName: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        description: json["description"] == null ? null : json["description"],
        userClass: json["class"] == null ? null : json["class"],
        followers: json["followers"] == null ? null : json["followers"],
        // createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": (firstName == null && lastName == null)
            ? null
            : firstName + lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "description": description == null ? null : description,
        "class": userClass == null ? null : userClass,
        "followers": followers == null ? null : followers,
        "createdDate":
            createdDate == null ? null : createdDate.toIso8601String(),
      };
}

class UserError {
  int code;
  Object message;

  UserError({required this.code, required this.message});
}
