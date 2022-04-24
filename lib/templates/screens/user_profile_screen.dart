import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/providers/sessions.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/user-profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _profilePageUI(SessionProvider userSession) {
    if (userSession.loading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (userSession.sessionError != null) {
      return Container(
        child: Center(
          // child: Text('Book Error'),
          child: Text(
            userSession.sessionError!.message.toString(),
          ),
          // ),
        ),
      );
    }

    Session? userSessionData = userSession.session;
    return Container(
      child: Column(
        children: [
          Text(userSessionData!.id),
          Text(userSessionData.accessToken),
          Text(userSessionData.accessTokenExpiry.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    SessionProvider userSession = (context).watch<SessionProvider>();

    return Container(
      child: _profilePageUI(userSession),
    );
  }
}
