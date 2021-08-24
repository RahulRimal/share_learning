import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;

  CustomImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoViewRouteWrapper(
              imageProvider: NetworkImage(
                this.imageUrl,
              ),
            ),
          ),
        );
      },
      child: PhotoView(
        imageProvider: NetworkImage(this.imageUrl),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}

class PhotoViewRouteWrapper extends StatelessWidget {
  
  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  
  
  const PhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
      ),
    );
  }
}
