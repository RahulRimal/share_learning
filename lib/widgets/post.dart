import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Post extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final DateTime boughtTime;
  final double price;
  final bool selling;

  Post({
    required this.title,
    required this.author,
    required this.description,
    required this.boughtTime,
    required this.price,
    required this.selling,
  });

  bool flexAuthorName = false;

  bool _shouldFlex(String testString) {
    if (testString.length > 11) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(
                top: 17,
                bottom: 50,
                left: 10,
                right: 10,
              ),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          this.title,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Available',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _shouldFlex(this.author)
                          ? Flexible(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.person),
                                    Text('Author'),
                                    Text(
                                      this.author,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Icon(Icons.person),
                                  Text('Author'),
                                  Text(
                                    this.author,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history),
                            Text('Bought time'),
                            Text(
                              '1 Year ago',
                              style: TextStyle(
                                color: Colors.yellow[300],
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.monetization_on),
                            Text('Price'),
                            Text(
                              'Rs.$price',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shop,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'Add to Wishlist',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: 100,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selling
                    ? Theme.of(context).primaryColor
                    : Colors.green[700],
              ),
              child: Text(
                selling ? 'Selling' : 'Buying',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
