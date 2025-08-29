import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/route/my_router.dart';

import '../../app/config/config.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  lessonItem({required iconName, required title, required bodyText, required BuildContext context, required goTo}){
    return GestureDetector(
      onTap: ()=>context.pushNamed(goTo),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // height: 50,
            width: context.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorResources.primary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontFamily().semiBold,).pad(left: 120),
                SizedBox(height: 4,),
                Text(bodyText, style: FontFamily().regular.copyWith(fontSize: context.locale.languageCode == 'en'?14:12),).pad(left: 120)
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child:
            // Lottie.asset('assets/LottieLogo1.json', width: 120, height: 120,),
            Image.asset('assets/images/$iconName.png', width: 120, height: 120,).pad(left: 10,bottom: 10),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: ColorResources.primary,
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              spreadRadius: 4.0
          ),
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[ColorResources.primary,ColorResources.primaryGradient]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/left_line.png', width: 50, height: 50,),
              Text(tr('lessons'), style: FontFamily().bold.copyWith(fontSize: context.locale.languageCode == 'en'?20:18),).pad(left: 8, right: 8),
              Image.asset('assets/images/right_line.png', width: 50, height: 50,),
            ],
          ),
          lessonItem(
              iconName: 'cat',
              title: '${tr('myanmar')}${tr('language')}',
              bodyText: tr('learn_myanmar_lang'),
              context: context,
            goTo: RouteName.myanmarView
          ),
          SizedBox(height: 15,),
          lessonItem(
              iconName: 'bird',
              title: '${tr('english')}${tr('language')}',
              bodyText: tr('learn_english_lang'),
              context: context,
              goTo: RouteName.englishView
          ),
          SizedBox(height: 15,),
          lessonItem(
              iconName: 'fish',
              title: tr('math'),
              bodyText: tr('learn_math'),
              context: context,
              goTo: RouteName.math
          ),
          SizedBox(height: 15,),
        ],
      ).pad(left: 16, right: 16, top: 3, bottom: 3),
    );
  }
}
