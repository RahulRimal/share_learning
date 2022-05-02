import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/sessions.dart';
import 'package:share_learning/providers/users.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/font_manager.dart';
import 'package:share_learning/templates/managers/style_manager.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';
import 'package:share_learning/templates/screens/home_screen.dart';
import 'package:share_learning/templates/screens/login_screen.dart';
import 'package:share_learning/templates/screens/user_posts_screen.dart';

class AppDrawer extends StatelessWidget {
  // User user;
  AppDrawer(this.loggedInSession);

  // final String accessToken;
  final Session loggedInSession;

  // AppDrawer({required this.user});

  // Future<User> _getSessionUser(context) async {
  //   User user = await Provider.of<Users>(context).getUserByToken(accessToken);
  //   return user;
  // }

  Users users = new Users(
    // Session(
    //   id: '0',
    //   userId: '0',
    //   accessToken: 'abc',
    //   accessTokenExpiry: DateTime(2050),
    //   refreshToken: 'abc',
    //   refreshTokenExpiry: DateTime(2050),
    // ),
    null,
  );

  List<DrawerItem> _drawerItems = [
    DrawerItem(
      icon: Icons.home,
      title: 'Home',
      route: HomeScreen.routeName,
    ),
    DrawerItem(
      icon: Icons.add_circle,
      title: 'Add Post',
      route: AddPostScreen.routeName,
    ),
    DrawerItem(
      icon: Icons.person,
      title: 'Profile',
      route: UserPostsScreen.routeName,
    ),
    // DrawerItem(
    //   icon: Icons.exit_to_app,
    //   title: 'Logout',
    //   route: LoginScreen.routeName,
    // ),
  ];

  Widget getDrawerItem(BuildContext context, DrawerItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
          title: Text(
            item.title,
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s18,
            ),
          ),
          leading: Icon(
            item.icon,
            color: Colors.white,
          ),
          onTap: () {
            if (item.route == HomeScreen.routeName)
              Navigator.pushNamed(context, item.route,
                  arguments: {'authSession': loggedInSession});
            if (item.route == AddPostScreen.routeName)
              Navigator.pushNamed(context, item.route);
            if (item.route == UserPostsScreen.routeName)
              Navigator.pushNamed(context, item.route, arguments: {
                'uId': loggedInSession.userId,
                'loggedInUserSession': loggedInSession
              });
          }),
    );
  }

  Future<User?> _getSessionUser() async {
    // await users.getUserByToken(accessToken);
    await users.getUserByToken(loggedInSession.accessToken).then((value) {
      return users.user;
    });
    if (users.user != null)
      return users.user;
    else {
      // await users.getUserByToken(accessToken);
      await users.getUserByToken(loggedInSession.accessToken).then((value) {
        return users.user;
      });
      return users.user;
    }
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
                  // child: Text('Error fetching data please restart the app'),
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
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
                              users.user!.firstName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.s18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.account_circle,
                      //     color: Colors.white,
                      //   ),
                      //   title: Text(
                      //     'Profile',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: FontSize.s18,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.home,
                      //     color: Colors.white,
                      //   ),
                      //   title: Text(
                      //     'Your Posts',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: FontSize.s18,
                      //     ),
                      //   ),
                      //   // onTap: () {
                      //   //   Navigator.pop(context);
                      //   // },
                      //   onTap: () => Navigator.of(context).pushNamed(
                      //     UserPostsScreen.routeName,
                      //     arguments: {
                      //       'uId': loggedInSession.userId,
                      //       'loggedInUserSession': loggedInSession,
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.home,
                      //     color: Colors.white,
                      //   ),
                      //   title: Text(
                      //     'Home',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: FontSize.s18,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.logout,
                      //     color: Colors.white,
                      //   ),
                      //   title: Text(
                      //     'Log out',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: FontSize.s18,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     Provider.of<Books>(context, listen: false)
                      //         .setBooks([]);
                      //     users.logoutUser(loggedInSession.id);

                      //     Provider.of<Comments>(context, listen: false)
                      //         .setComments([]);

                      //     //     .logout(accessToken);
                      //     Navigator.pushReplacementNamed(
                      //         context, LoginScreen.routeName);
                      //   },
                      // ),

                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return getDrawerItem(
                                  context, _drawerItems[index]);
                            },
                            itemCount: _drawerItems.length),
                      ),

                      Spacer(),

                      ListTile(
                        tileColor: ColorManager.white,
                        leading: Icon(
                          Icons.logout,
                          color: ColorManager.primary,
                        ),
                        title: Text(
                          'Log out',
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        onTap: () {
                          Provider.of<Books>(context, listen: false)
                              .setBooks([]);
                          users.logoutUser(loggedInSession.id);

                          Provider.of<Comments>(context, listen: false)
                              .setComments([]);
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    // 'Error fetching data please restart the app',
                    'Something went wrong',
                    // snapshot.data.toString(),
                    style: getBoldStyle(color: ColorManager.white),
                  ),
                );
              }
            }
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

class DrawerItem {
  String title;
  IconData icon;
  String route;
  DrawerItem({required this.title, required this.icon, required this.route});
}
