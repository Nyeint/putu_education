import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

class BackFlipCard extends StatelessWidget {
  String image;
  BackFlipCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: context.width,
      // height: context.height,
      decoration: BoxDecoration(
          border: Border.all(color: ColorResources.primary, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorResources.lightBg.withOpacity(0.5)
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorResources.white, width: 7),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            shape: BoxShape.rectangle
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      border: Border.all(color: ColorResources.lightBg),
                    ),
                    child:
                    Icon(Icons.image,color: ColorResources.lightBg, size: 30,),
                  ),
                  fit: BoxFit.cover,
                )
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.white
              ),
              child: Icon(Icons.check, color: ColorResources.primary, size: context.width*0.15,),
            )
          ],
        ),
      ),
    );
  }
}
