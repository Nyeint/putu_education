import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../app/config/config.dart';
import '../../app/service/tts_service.dart';
import 'my_icon.dart';

FlutterTts flutterTts = TtsService.instance.flutterTts;
void showImageDialog({required BuildContext context, required List<String> photoList, required List<String> nameList,
 required int selectedIndex}) {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (context, StateSetter setState){
            return Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            // onTap: picClose,
                              onTap: () async {
                                await flutterTts.stop();
                                Navigator.pop(context);
                              },
                              child: MyIcon(iconName: 'pic_close', padding: 7))),
                      SizedBox(height: 8,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ColorResources.primary),
                            // color: ColorResources.lightBg,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                      child: CachedNetworkImage(
                                        height: context.height/3,
                                        width: context.width-60,
                                        imageUrl: photoList[selectedIndex],
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
                                  Positioned(
                                      right: 12,
                                      top: 12,
                                      child: GestureDetector(
                                          onTap: ()=>flutterTts.speak(nameList[selectedIndex]),
                                          child: MyIcon(iconName: 'volume',)))
                                ],
                              ),
                              Container(
                                // height: 50,
                                height: context.width*0.13,
                                // height: context.width/8,
                                decoration: BoxDecoration(
                                  color: ColorResources.lightBg,
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
                                child: Center(child: Text(nameList[selectedIndex], style: FontFamily().regular,)),
                              ),
                            ],
                          )
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(selectedIndex>0)
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex=selectedIndex-1;
                                  });
                                  flutterTts.speak(nameList[selectedIndex]);
                                },
                                child: MyIcon(iconName: 'previous', padding: 12,)),
                          SizedBox(width: 30,),
                          if(selectedIndex<photoList.length-1)
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex=selectedIndex+1;
                                  });
                                  print("hello selected index ${selectedIndex}");
                                  flutterTts.speak(nameList[selectedIndex]);
                                },
                                child: MyIcon(iconName: 'next', padding: 12)),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    },
  );
}