import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app/config/color_resources.dart';

class FrontFlipCardItem extends StatelessWidget {
  String image;
  bool isSelected;
  FrontFlipCardItem({super.key, required this.image, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: isSelected?ColorResources.primary:ColorResources.white, width: 7),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: CachedNetworkImage(
            imageUrl: image,
            // placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                border: Border.all(color: ColorResources.lightBg),
              ),
              child:
              Icon(Icons.image,color: ColorResources.lightBg, size: 30,),
            ),
            // height: height,
            // width: width,
            fit: BoxFit.cover,
          )
      ),
    );
  }
}
