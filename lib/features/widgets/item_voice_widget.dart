// Path: widgets/item_voice_widget.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

import 'my_icon.dart';

class ItemVoiceWidget extends StatelessWidget {
  String photo;
  String name;
  String audio;
  /// When set, the card is [width] wide with a square image; otherwise the
  /// legacy screen-relative size is used.
  final double? width;
  ItemVoiceWidget({super.key, required this.photo, required this.name, required this.audio, this.width});

  // Shared across all cards (mirrors the previous shared TtsService instance)
  // so tapping another card's volume icon stops whatever is currently
  // playing instead of overlapping it.
  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> speak() async {
    if (audio.isEmpty) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(audio));
  }

  @override
  Widget build(BuildContext context) {
    final double width = this.width ?? context.width/3.8;
    // double height = context.width/2.85;
    final double height = this.width != null ? width : context.width/3.8 +15;
    final double labelHeight = this.width != null ? width * 0.45 : context.width*0.13;
    return SizedBox(
      width: width,
      height: height+labelHeight,
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
                height: labelHeight,
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
