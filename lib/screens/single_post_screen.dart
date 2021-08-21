import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/app_drawer.dart';

class SinglePostScreen extends StatelessWidget {
  static const routeName = '/post-details';

  var bookId;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    if (args != null) {
      bookId = args['id'];
    }

    Book selectedPost = Provider.of<Books>(context).getBookById(bookId);


    bool _shouldFlex(String testString) {
    if (testString.length > 11) return true;
    return false;
  }

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
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
                              'Bought 1 Year Ago',
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
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: selectedPost.pictures != null ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedPost.pictures!.length,
                  itemBuilder: (context, index) =>
                      // Post Image Starts Here
                      Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Image.network(
                        selectedPost.pictures![index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Post Image ends Here,
                ): Center(
                  child: Text('No Images found',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),

              // Image Gallery Ends Here
      
              // Comments Starts here
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Comments',
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

              // Comment Post Starts Here
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child:Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(    
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
                      ),
                      _shouldFlex(selectedPost.author)
                            ? Flexible(
                                child: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    selectedPost.author,
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
                                  selectedPost.author,
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
                  Container(
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 20,
                        ),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
              ),

              // Comment Post Starts Here
      
              // Comments Ends here
            ],
          ),
        ),
      ),
    );
  }
}
