import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/providers/comment.dart';
import 'package:share_learning/providers/user.dart';
import 'package:share_learning/screens/edit_post_screen.dart';
import 'package:share_learning/screens/user_posts_screen.dart';
import 'package:share_learning/widgets/app_drawer.dart';
import 'package:share_learning/widgets/image_gallery.dart';
import 'package:share_learning/widgets/post_comment.dart';

class SinglePostScreen extends StatelessWidget {
  static const routeName = '/post-details';

  var bookId;

  TextEditingController commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    // if (args != null) {
    if (true) {
      bookId = args['id'];
    }

    Book selectedPost = Provider.of<Books>(
      context,
      listen: false,
    ).getBookById(bookId);
    List<Comment> postComments = Provider.of<Comments>(
      context,
      listen: false,
    ).getPostComments(bookId);

    // bool _shouldFlex(String testString) {
    //   if (testString.length > 11) return true;
    //   return false;
    // }

    Duration timeDifference =
        NepaliDateTime.now().difference(selectedPost.boughtTime);
    double duration =
        double.parse((timeDifference.inDays / 365).toStringAsFixed(1));

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditPostScreen.routeName, arguments: bookId);
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
                  selectedPost.title,
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
                          'uId': selectedPost.uId,
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

              postComments.isEmpty
                  ? Container(
                      child: Center(
                        child: Text(
                          'No Comments Yet',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: postComments.length,
                          itemBuilder: (context, index) {
                            User commentUser = Provider.of<Users>(context)
                                .getUser(postComments[index].uId);

                            // Comment Post Starts Here

                            return PostComment(
                              commentUser,
                              postComments[index].commentBody,
                            );

                            // Comment Post Ends Here
                          }),
                    ),
              // Comments Ends here

              // Add your comment starts here !!

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Your Comment',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: commentController,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => print(commentController.text),
                                icon: Icon(
                                  Icons.send,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              // Add your comment ends here !!
            ],
          ),
        ),
      ),
    );
  }
}
