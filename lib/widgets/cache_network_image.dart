
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

dynamic cacheImage({
  required String imageUrl,
  required String placeHolderImageUrl,
  required double width,
  required double height
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          )
        ),
      );
    },
    placeholder: (context, url) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: Image.asset(
          placeHolderImageUrl
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: Image.asset(
          placeHolderImageUrl
        ),
      );
    }
  );
}
