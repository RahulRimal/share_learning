import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/models/user.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/users.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/style_manager.dart';
import 'package:share_learning/templates/screens/home_screen.dart';
import 'package:share_learning/templates/widgets/app_drawer.dart';
import 'package:share_learning/templates/widgets/image_gallery.dart';
import 'package:share_learning/templates/widgets/post_comments.dart';

import 'edit_post_screen.dart';
import 'user_posts_screen.dart';

class SinglePostScreen extends StatelessWidget {
  static const routeName = '/post-details';

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

  User loggedInUser = new User(
    id: '0',
    firstName: 'temp',
    lastName: 'Name',
    email: '',
    image: null,
    username: 'temp',
    description: '',
    userClass: '',
    followers: '',
    createdDate: DateTime(2050),
  );

  var bookId;
  // var loggedInUserSession;

  Future<void> _getSessionUser(String accessToken) async {
    await users.getUserByToken(accessToken);
    if (users.user != null)
      loggedInUser = users.user!;
    else {
      await users.getUserByToken(accessToken);
      loggedInUser = users.user!;
    }
  }

  // final _form = GlobalKey<FormState>();
  // TextEditingController commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    // if (args != null) {
    // if (true) {
    // bookId = args['id'] != null ? args['id'] : 1;
    bookId = args['id'];
    final Session loggedInUserSession = args['loggedInUserSession'] as Session;

    // final Comment? _editComment = args['editComment'];
    // if (_editComment != null) commentController.text = _editComment.commentBody;

    // if (_editComment != null) commentController.text = _editComment.commentBody;

    users.getUserByToken(loggedInUserSession.accessToken);
    // final User loggedInUser = _getSessionUser(loggedInUserSession.accessToken);
    // }

    Book selectedPost = Provider.of<Books>(
      context,
      listen: false,
    ).getBookById(bookId);

    // List<Comment> postComments = Provider.of<Comments>(
    //   context,
    //   listen: false,
    // ).getPostComments(bookId);

    Comments comments = context.watch<Comments>();

    Books books = context.watch<Books>();

    // bool _shouldFlex(String testString) {
    //   if (testString.length > 11) return true;
    //   return false;
    // }

    Duration timeDifference =
        NepaliDateTime.now().difference(selectedPost.boughtDate);
    double duration =
        double.parse((timeDifference.inDays / 365).toStringAsFixed(1));

    return Scaffold(
        drawer: AppDrawer(loggedInUserSession),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: loggedInUserSession.userId == selectedPost.userId
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Navigator.of(context)
                        //     .pushNamed(EditPostScreen.routeName, arguments: {
                        //   'bookId': bookId,
                        //   'loggedInUserSession': loggedInUserSession
                        // });

                        if (await books.deletePost(
                            loggedInUserSession, bookId)) {
                          // Navigator.pop(context);
                          Navigator.of(context).pushReplacementNamed(
                              HomeScreen.routeName,
                              arguments: {
                                'authSession': loggedInUserSession,
                              });
                          BotToast.showSimpleNotification(
                            title: 'Post deleted successfully',
                            duration: Duration(seconds: 3),
                            backgroundColor: ColorManager.primary,
                            titleStyle: getBoldStyle(color: ColorManager.white),
                            align: Alignment(1, 1),
                          );
                        } else {
                          BotToast.showSimpleNotification(
                            title: 'Colubn\'t delete post!!',
                            duration: Duration(seconds: 3),
                            backgroundColor: ColorManager.primary,
                            titleStyle: getBoldStyle(color: ColorManager.white),
                            align: Alignment(1, 1),
                          );
                        }
                      },
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: loggedInUserSession.userId == selectedPost.userId
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditPostScreen.routeName, arguments: {
                          'bookId': bookId,
                          'loggedInUserSession': loggedInUserSession
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.shop),
                      onPressed: () {
                        // Navigator.of(context).pushNamed(EditPostScreen.routeName,
                        //     arguments: {
                        //       'bookId': bookId,
                        //       'loggedInUserSession': loggedInUserSession
                        //     });
                      },
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Text(
                    selectedPost.bookName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          UserPostsScreen.routeName,
                          arguments: {
                            'uId': selectedPost.userId,
                            'loggedInUserSession': loggedInUserSession,
                          },
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.person),
                            Text(
                              'Author',
                            ),
                            Text(
                              selectedPost.author,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                              ),
                              child: Text(
                                // 'Bought 1 Year Ago',
                                duration > 1.0
                                    ? '$duration Years ago'
                                    : duration == 1.0
                                        ? '$duration Year ago'
                                        : duration == 0.1
                                            ? '1 Month ago'
                                            : '${((duration % 1) * 10).floor()} Months ago',

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    selectedPost.description,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Total Books: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${selectedPost.bookCount}',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Total Price: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Rs.${selectedPost.price}',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Image Gallery Starts Here

                ImageGallery(true, this.bookId),

                // Image Gallery Ends Here

                // Comments Starts here
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          height: 5,
                          indent: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // postComments.isEmpty
                //     ? Container(
                //         child: Center(
                //           child: Text(
                //             'No Comments Yet',
                //             style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ),
                //       )
                // :

                PostComments(loggedInUserSession, comments, this.bookId),

                // Container(
                //   height: 200,

                //   child: FutureBuilder(
                //     future: comments.getPostComments(bookId),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(
                //             color: ColorManager.primary,
                //           ),
                //         );
                //       } else {
                //         if (snapshot.hasError) {
                //           return Center(
                //             child: Text(
                //                 'Error fetching data please restart the app'),
                //             // child: Text(snapshot.error.toString()),
                //           );
                //         } else {
                //           if (comments.comments.isEmpty)
                //             return Container(
                //               child: Text(
                //                 'No Comments Yet',
                //                 style: getBoldStyle(
                //                     fontSize: FontSize.s17, color: Colors.black),
                //               ),
                //             );
                //           return ListView.builder(
                //             // itemCount: snapshot.data.length,
                //             itemCount: comments.comments.length,
                //             itemBuilder: (context, index) {
                //               return PostComment(
                //                 // snapshot.data[index].user,
                //                 // snapshot.data[index].commentBody,
                //                 // comments.comments[index].user,
                //                 loggedInUserSession,
                //                 comments.comments[index],
                //               );
                //               // return Text('Comment will be here');
                //             },
                //           );
                //         }
                //       }
                //     },
                //   ),
                // ),
                // Comments Ends here

                // Add your comment starts here !!
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 5,
                //     vertical: 15,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Add Your Comment',
                //         style: TextStyle(
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Form(
                //             key: _form,
                //             child: Expanded(
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(vertical: 10),
                //                 child: TextFormField(
                //                   // controller: commentController,
                //                   initialValue: _editComment != null
                //                       ? _editComment.commentBody
                //                       : '',
                //                   cursorColor: Theme.of(context).primaryColor,
                //                   decoration: InputDecoration(
                //                     suffixIcon: IconButton(
                //                       onPressed: () {
                //                         print(commentController.text);
                //                       },
                //                       icon: Icon(
                //                         Icons.send,
                //                         color: Theme.of(context).primaryColor,
                //                       ),
                //                     ),
                //                     border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(20),
                //                     ),
                //                   ),
                //                 ),
                //                 // child: TextField(
                //                 //   controller: commentController,
                //                 //   cursorColor: Theme.of(context).primaryColor,
                //                 //   decoration: InputDecoration(
                //                 //     suffixIcon: IconButton(
                //                 //       onPressed: () {
                //                 //         print(commentController.text);
                //                 //       },
                //                 //       icon: Icon(
                //                 //         Icons.send,
                //                 //         color: Theme.of(context).primaryColor,
                //                 //       ),
                //                 //     ),
                //                 //     border: OutlineInputBorder(
                //                 //       borderRadius: BorderRadius.circular(20),
                //                 //     ),
                //                 //   ),
                //                 // ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // Add your comment ends here !!
              ],
            ),
          ),
        ),
        bottomSheet: loggedInUserSession.userId != selectedPost.userId
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {},
                child: const Text(
                  'Order this book',
                  style: TextStyle(fontSize: 24),
                ),
              )
            : SizedBox(
                height: 5.0,
              ));
  }
}
