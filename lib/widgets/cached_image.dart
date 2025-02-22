import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  double? fontSize;
  String? urlImage;
  double? radios;
  double? width;
  double? height;

  CachedImage(
      {super.key,
      this.urlImage,
      this.radios,
      this.fontSize,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radios ?? 1)),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: urlImage ??
            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
          width: width ?? 15,
          height: height ?? 10,
          child: Text('$error', style: TextStyle(fontSize: fontSize ?? 5)),
        ),
        placeholder: (context, url) => Container(
          width: width ?? 15,
          height: height ?? 10,
          color: Colors.grey,
          child: Center(
            child: Text(
              'loading',
              style: TextStyle(fontSize: fontSize ?? 5),
            ),
          ),
        ),
      ),

      // Container(
      //   width: width ?? 15,
      //   height: height ?? 10,
      //   color: Colors.grey,
      //   child: Center(
      //     child: Text(
      //       'loading',
      //       style: TextStyle(fontSize: fontSize ?? 5),
      //     ),
      //   ),
      // ),
    );
  }
}
