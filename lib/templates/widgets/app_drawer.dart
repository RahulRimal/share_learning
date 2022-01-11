import 'package:flutter/material.dart';
import 'package:share_learning/templates/screens/add_post_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Text(
              'Rahul Rimal',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).accentColor,
            title: Text(
              'Create new Post',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(AddPostScreen.routeName),
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bookmark),
                Text('Wishlist'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
