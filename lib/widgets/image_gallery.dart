import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/widgets/custom_image.dart';

class ImageGallery extends StatelessWidget {
  final String bookId;

  ImageGallery(this.bookId);

  @override
  Widget build(BuildContext context) {
    Book selectedPost = Provider.of<Books>(context).getBookById(bookId);

    return // Image Gallery Starts Here
        Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: selectedPost.pictures != null
          ? ListView.builder(
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
                  // child: Image.network(
                  //   selectedPost.pictures![index],
                  //   fit: BoxFit.cover,
                  // ),
                  // child: PhotoView(
                  //   imageProvider: NetworkImage(selectedPost.pictures![index]),
                  //   minScale: PhotoViewComputedScale.contained * 0.8,
                  //   maxScale: PhotoViewComputedScale.covered * 2,
                  // ),

                  child: CustomImage(
                    selectedPost.pictures![index],
                  ),

                ),
              ),
              // Post Image ends Here,
            )
          : Center(
              child: Text(
                'No Images found',
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );

    // Image Gallery Ends Here
  }
}
