import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/sessions.dart';
import 'package:share_learning/templates/managers/values_manager.dart';
import 'package:share_learning/templates/screens/user_profile_edit_screen.dart';
import 'package:share_learning/templates/utils/user_helper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/user-profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _profilePageUI(SessionProvider userSession, User user) {
    print(user.firstName);
    print(user.image);
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
      padding: EdgeInsets.only(top: AppPadding.p12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
              UserHelper.userProfileImage(user),
            ),
          ),
          Text(userSessionData!.accessToken),
          Text(userSessionData.accessTokenExpiry.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    Session loggedInUserSession = args['loggedInUserSession'] as Session;

    User user = args['user'] as User;

    // Session userSession = args['session'] as Session;

    SessionProvider userSession = (context).watch<SessionProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(
                UserProfileEditScreen.routeName,
                arguments: {
                  // 'loggedInUserSession': userSession.session,
                  'loggedInUserSession': loggedInUserSession,
                  'user': user,
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _profilePageUI(userSession, user),
      ),
    );
  }
}
