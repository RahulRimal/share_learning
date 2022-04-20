import 'package:flutter/cupertino.dart';
import 'package:share_learning/data/user_api.dart';
import 'package:share_learning/models/api_status.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/sessions.dart';

class Users with ChangeNotifier {
  Users(this._session);
  // List<User> _users = [
  //   User(
  //     id: '0',
  //     firstName: 'Rahul',
  //     lastName: 'Rimal',
  //     userName: 'RahulR',
  //     password: '123',
  //     image:
  //         'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
  //   ),
  //   User(
  //     id: '1',
  //     firstName: 'Surendra',
  //     lastName: 'Jha',
  //     userName: 'SJha',
  //     password: '123',
  //     image:
  //         'https://cdn.pixabay.com/photo/2021/08/10/18/32/cat-6536684__340.jpg',
  //   ),
  //   User(
  //     id: '2',
  //     firstName: 'Krishna Pd.',
  //     lastName: 'Rimal',
  //     userName: 'KrishR',
  //     password: '123',
  //     image:
  //         'https://cdn.pixabay.com/photo/2021/06/25/17/51/ladybug-6364312__340.jpg',
  //   ),
  // ];

  List<User> _users = [];

  final Session _session;

  late User _user;
  // User? _user;
  bool _loading = false;
  UserError? _userError;

  bool get loading => _loading;

  User get user {
    return _user;
  }

  Session get session {
    return _session;
  }

  UserError? get userError {
    return _userError;
  }

  void setUser(User user) {
    _user = user;
  }

  void setLoading(bool loading) {
    _loading = loading;
    // notifyListeners();
  }

  void setUserError(UserError? userError) {
    _userError = userError;
  }

  getUserByToken(String accessToken) async {
    setLoading(true);

    var response = await UserApi.getUserFromToken(accessToken);

    if (response is Success) {
      setUser(response.response as User);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse,
      );
      setUserError(userError);
    }
    setLoading(false);
    // notifyListeners();
  }

  List<User> get users {
    return [..._users];
  }

  User getUserById(String uId) {
    return users.firstWhere((user) => user.id == uId);
  }
}
