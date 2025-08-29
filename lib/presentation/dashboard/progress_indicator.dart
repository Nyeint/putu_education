import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/route/my_router.dart';
import '../../app/config/config.dart';

class ProgressIndicatorView extends StatelessWidget {
  const ProgressIndicatorView({super.key});

  progressItem(String title, String mark, BuildContext context, String goTo){
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      constraints: const BoxConstraints(
        minWidth: 90,
      ),
      // width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
          ),
          BoxShadow(
            color: ColorResources.secondary,
            spreadRadius: -2.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      // color: ColorResources.secondary,
      child: Column(
        children: [
          Text(title, style: FontFamily().semiBold.copyWith(fontSize: context.locale.languageCode == 'en'?16:14),),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                  AssetImage("assets/icons/star.png",),
                  fit: BoxFit.fill),
              // shape: BoxShape.rectangle
            ),
            child: Center(child: Text(mark,)),
          ),
          SizedBox(height: 8,),
          GestureDetector(
            onTap: ()=> context.pushNamed(goTo),
            child: Container(
              padding: EdgeInsets.only(left: 14,right: 14, top: 3, bottom: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColorResources.primary, width: 2),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.white,ColorResources.primary]),
              ),
              child: Center(child: Text(tr('play'),style: FontFamily().medium.copyWith(fontSize: context.locale.languageCode == 'en'?12:10,))
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/yellow_slider.png",),
            fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          Text(tr('progress_indication'), style: FontFamily().bold),
          SizedBox(height: 8,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                progressItem(tr('english'),'50', context, RouteName.englishGame),
                SizedBox(width: 8,),
                progressItem(tr('myanmar'),'40',context, RouteName.englishGame),
                SizedBox(width: 8,),
                progressItem(tr('math'),'40',context, RouteName.mathGame),
              ],
            ),
          )
        ],
      ),
    ).pad(left: 16, right: 16);
  }
}
