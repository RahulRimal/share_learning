import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.image,
  });
}

class Users with ChangeNotifier {
  List<User> _users = [
    User(
      id: '0',
      firstName: 'Rahul',
      lastName: 'lastName',
      userName: 'RahulR',
      password: '123',
      image: 'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
    ),
    User(
      id: '1',
      firstName: 'Surendra',
      lastName: 'Jha',
      userName: 'SJha',
      password: '123',
      image: 'https://cdn.pixabay.com/photo/2021/08/10/18/32/cat-6536684__340.jpg',
    ),
    User(
      id: '2',
      firstName: 'Krishna Pd.',
      lastName: 'Rimal',
      userName: 'KrishR',
      password: '123',
      image: 'https://cdn.pixabay.com/photo/2021/06/25/17/51/ladybug-6364312__340.jpg',
    ),
  ];

  List<User> get users
  {
    return [..._users];
  }


  User getUser(String uId)
  {
    return users.firstWhere((user) => user.id == uId);
  }














}
