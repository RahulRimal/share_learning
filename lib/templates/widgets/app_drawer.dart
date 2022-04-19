import 'package:flutter/material.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/font_manager.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';
import 'package:share_learning/templates/screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  // User user;

  // AppDrawer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 40),
        color: ColorManager.lightPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
                  ),
                  Text(
                    'Rahul Rimal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.s18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s18,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
            // ListTile(
            //   tileColor: Theme.of(context).primaryColor,
            //   leading: Text(
            //     'Rahul Rimal',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            //   trailing: CircleAvatar(
            //     backgroundImage: NetworkImage(
            //         'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            //   ),
            // ),
            // ListTile(
            //   tileColor: Theme.of(context).accentColor,
            //   title: Text(
            //     'Create new Post',
            //     style: TextStyle(
            //       fontSize: 15,
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            //   onTap: () =>
            //       Navigator.of(context).pushNamed(AddPostScreen.routeName),
            // ),
            // ListTile(
            //   leading: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Icon(Icons.bookmark),
            //       Text('Wishlist'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
