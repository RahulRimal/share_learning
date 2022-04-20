import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/templates/screens/user_posts_screen.dart';

class PostComment extends StatelessWidget {
  // final Book selectedPost;
  final User commentUser;
  final String comment;

  PostComment(this.commentUser, this.comment);

  bool _shouldFlex(String testString) {
    if (testString.length > 11) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (Provider.of<Books>(
                      context,
                      listen: false,
                    ).hasPostByUser(commentUser.id)) {
                      Navigator.of(context).pushNamed(
                        UserPostsScreen.routeName,
                        arguments: {
                          'uId': commentUser.id,
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      final snackBar = SnackBar(
                        content: Text(
                          'No posts by ${commentUser.firstName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // action: SnackBarAction(
                        //   label: 'Close',
                        //   textColor: Theme.of(context).primaryColor,
                        //   onPressed: () => print('Pressed'),
                        // ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          // commentUser.image as String,
                          commentUser.image != null
                              ? commentUser.image as String
                              : 'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
                        ),
                      ),
                      _shouldFlex(
                              // '${commentUser.firstName} ${commentUser.lastName}')
                              '${commentUser.firstName}')
                          ? Flexible(
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  // '${commentUser.firstName} ${commentUser.lastName}',
                                  '${commentUser.firstName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 100,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${commentUser.firstName} ${commentUser.lastName}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 20,
                      ),
                      child: Text(
                        comment,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
