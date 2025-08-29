import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';

import '../../widgets/item_decoration.dart';

class TitleItemWidget extends StatelessWidget {
  String title;
  String iconName;
  String goTo;
  int score;
  TitleItemWidget({super.key, required this.title, required this.iconName, required this.goTo, required this.score});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width*0.7,
      child: Stack(
        children: [
          Align(
            // top: 60,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 5  ,right: 5),
              width: context.width-32,
              decoration: BoxDecoration(
                color: ColorResources.lightBg,
                // color: ColorResources.secondary,
                image: DecorationImage(
                    image: AssetImage("assets/images/game_item_bg.png",),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        width: context.width*0.55,
                        height: context.width*0.55,
                        'assets/images/$iconName.png',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text("${tr('score')}:", style: FontFamily().medium,),
                              SizedBox(width: 10,),
                              Container(
                                  width: context.width*0.13,
                                  height: context.width*0.13,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                        AssetImage("assets/icons/star.png",),
                                        fit: BoxFit.fill),
                                    // shape: BoxShape.rectangle
                                  ),
                                  child: Center(child: Text(score.toString(), style: FontFamily().semiBold,))
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: ()=>context.pushNamed(goTo),
                            child: Container(
                                padding: EdgeInsets.only(left: 25, right: 25,top: 5, bottom: 5),
                                decoration: selectedTabDecoration(),
                                child: Text(tr('play'), style: FontFamily().medium,)
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      )
                    ]
                ),
              ),
            ),
          ),
          Align(
            // top: 0,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  // height: 60,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  width: context.width-32,
                  // padding: EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ColorResources.secondary,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.4,
                        offset: Offset(0, 2.0), // bottom shadow
                      ),
                    ],
                  ),
                  child: Text(title, style: FontFamily().semiBold.copyWith(fontSize: FontSize().twenty),),
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}
