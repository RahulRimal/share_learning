import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/sessions.dart';
import 'package:share_learning/providers/users.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/font_manager.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';
import 'package:share_learning/templates/screens/login_screen.dart';
import 'package:share_learning/templates/screens/user_posts_screen.dart';

class AppDrawer extends StatelessWidget {
  // User user;
  AppDrawer(this.accessToken);

  final String accessToken;

  // AppDrawer({required this.user});

  // Future<User> _getSessionUser(context) async {
  //   User user = await Provider.of<Users>(context).getUserByToken(accessToken);
  //   return user;
  // }

  Users users = new Users(
    Session(
      id: '0',
      userId: '0',
      accessToken: 'abc',
      accessTokenExpiry: DateTime(2050),
      refreshToken: 'abc',
      refreshTokenExpiry: DateTime(2050),
    ),
  );

  Future<User> _getSessionUser() async {
    await users.getUserByToken(accessToken);
    return users.user;
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<Users>(context, listen: false).getUserByToken(this.accessToken);

    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 40),
        color: ColorManager.lightPrimary,
        child: FutureBuilder(
          future: _getSessionUser(),
          // future: Provider.of<Users>(context, listen: false)
          //     .getUserByToken(this.accessToken),

          // future: users.getUserByToken(userSession.accessToken),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching data please restart the app'),
                  // child: Text(snapshot.error.toString()),
                );
              } else {
                return Container(
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
                              users.user.firstName,
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
                          'Your Posts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        // onTap: () {
                        //   Navigator.pop(context);
                        // },
                        onTap: () => Navigator.of(context).pushNamed(
                          UserPostsScreen.routeName,
                          arguments: {
                            'uId': users.user.id,
                            'loggedInUserSession': users.session,
                          },
                        ),
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

                          // Provider.of(context, listen: false)
                          //     .logout(accessToken);

                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                      ),
                    ],
                  ),
                );
              }
            }
            ;

            // child: Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Center(
            //         child: Column(
            //           children: [
            //             CircleAvatar(
            //               radius: 70,
            //               backgroundImage: NetworkImage(
            //                   'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            //             ),
            //             Text(
            //               // 'Rahul Rimal',
            //               user.firstName,
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: FontSize.s18,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 40,
            //       ),
            //       ListTile(
            //         leading: Icon(
            //           Icons.account_circle,
            //           color: Colors.white,
            //         ),
            //         title: Text(
            //           'Profile',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: FontSize.s18,
            //           ),
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(
            //           Icons.home,
            //           color: Colors.white,
            //         ),
            //         title: Text(
            //           'Profile',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: FontSize.s18,
            //           ),
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(
            //           Icons.home,
            //           color: Colors.white,
            //         ),
            //         title: Text(
            //           'Home',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: FontSize.s18,
            //           ),
            //         ),
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //       ListTile(
            //         leading: Icon(
            //           Icons.logout,
            //           color: Colors.white,
            //         ),
            //         title: Text(
            //           'Log out',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: FontSize.s18,
            //           ),
            //         ),
            //         onTap: () {
            //           // Navigator.pop(context);
            //           Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            //         },
            //       ),
            //       // ListTile(
            //       //   tileColor: Theme.of(context).primaryColor,
            //       //   leading: Text(
            //       //     'Rahul Rimal',
            //       //     style: TextStyle(
            //       //       color: Colors.white,
            //       //     ),
            //       //   ),
            //       //   trailing: CircleAvatar(
            //       //     backgroundImage: NetworkImage(
            //       //         'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            //       //   ),
            //       // ),
            //       // ListTile(
            //       //   tileColor: Theme.of(context).accentColor,
            //       //   title: Text(
            //       //     'Create new Post',
            //       //     style: TextStyle(
            //       //       fontSize: 15,
            //       //       color: Colors.white,
            //       //     ),
            //       //     textAlign: TextAlign.center,
            //       //   ),
            //       //   onTap: () =>
            //       //       Navigator.of(context).pushNamed(AddPostScreen.routeName),
            //       // ),
            //       // ListTile(
            //       //   leading: Row(
            //       //     mainAxisSize: MainAxisSize.min,
            //       //     children: [
            //       //       Icon(Icons.bookmark),
            //       //       Text('Wishlist'),
            //       //     ],
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          },
        ),
      ),
    );
  }
}
