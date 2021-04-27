import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  final double totalHeight;
  final double totalWidth;

  final double left;
  final double top;
  final double width;
  final double height;

  final String imageURL;

  MyNetworkImage({
    this.totalHeight = 100.0,
    this.totalWidth = 100.0,
    this.left = 0.0,
    this.top = 0.0,
    this.width = 100.0,
    this.height = 100.0,
    this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: MyClipper(
        left: left,
        top: top,
        width: width,
        height: height,
      ),
      child: CachedNetworkImage(
        alignment: Alignment.center,
        // fit: BoxFit.cover,
        height: totalHeight,
        width: totalWidth,
        imageUrl: imageURL,
        placeholder: (context, url) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double left;
  final double top;
  final double width;
  final double height;

  MyClipper({
    this.left,
    this.top,
    this.width,
    this.height,
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      left,
      top,
      width,
      height,
    );
//    final epicenter = Offset(size.width, size.height);
//    // Calculate distance from epicenter to the top left corner to make sure clip the image into circle.
//    final distanceToCorner = epicenter.dy;
//    final radius = distanceToCorner;
//    final diameter = radius;
//    return Rect.fromLTWH(
//        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
