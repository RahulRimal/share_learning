import 'package:flutter/material.dart';

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
              style: TextStyle(color: Colors.white),
            ),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
