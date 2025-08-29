import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../app/config/color_resources.dart';

class PhotoViewOverlay extends ModalRoute<void>{
  String image;

  PhotoViewOverlay({required this.image});
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black.withOpacity(0.7);

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => null;

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return
      Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.primaryGradient, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: PhotoView(
                      initialScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: BoxDecoration(
                          color: Colors.transparent
                      ),
                      tightMode: true,
                      filterQuality: FilterQuality.high,
                      imageProvider: NetworkImage(
                          image
                      )
                    // CachedNetworkImage(
                    //   imageUrl: '',
                    // ),
                    // imageProvider: FileImage(File(image))
                  ),
                ),
                // Positioned(
                //   right: 10,
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.close,
                //       color: Colors.white,
                //     ),
                //     onPressed: () async {
                //       Navigator.pop(context);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
  }
}