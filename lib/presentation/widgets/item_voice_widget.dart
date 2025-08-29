import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:putu_education/app/config/config.dart';

import '../../app/service/tts_service.dart';
import 'my_icon.dart';

class ItemVoiceWidget extends StatelessWidget {
  String photo;
  String name;
  ItemVoiceWidget({super.key, required this.photo, required this.name});

  FlutterTts flutterTts = TtsService.instance.flutterTts;

  speak() async{
    await flutterTts.stop();
    await flutterTts.speak(name);
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width/3.8;
    double height = context.width/2.85;

    return SizedBox(
      width: width,
      height: height+context.width*0.13,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: photo,
                          // placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              border: Border.all(color: ColorResources.lightBg),
                            ),
                            child:
                            Icon(Icons.image,color: ColorResources.lightBg, size: width,),
                          ),
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                        )
                    ),
                    Positioned(
                        right: 12,
                        top: 12,
                        child:  GestureDetector(
                            onTap: () => speak(),
                            child: MyIcon(iconName: 'volume',)))
                  ],
                ),
              )
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 50,
                height: context.width*0.13,
                width: width,
                // height: context.width/8,
                decoration: BoxDecoration(
                  color: ColorResources.primary,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.4,
                      offset: Offset(0, 2.0), // bottom shadow
                    ),
                  ],
                ),
                child: Center(child: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis,style: FontFamily().regular,)),
              )
          ),
        ],
      ),

    );
  }
}
