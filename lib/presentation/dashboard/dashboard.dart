import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/presentation/dashboard/lessons_view.dart';
import 'package:putu_education/presentation/dashboard/progress_indicator.dart';
import 'package:putu_education/presentation/test/phone_number.dart';
import 'package:putu_education/presentation/widgets/my_appbar.dart';
import 'package:putu_education/presentation/widgets/my_icon.dart';
import 'package:putu_education/route/my_router.dart';

import '../../app/config/font_family.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  // headerItem({required String iconName,required String goTo}){
  //   return GestureDetector(
  //     onTap: ()=>context.pushNamed(goTo),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: ColorResources.secondary,
  //       ),
  //       padding: EdgeInsets.all(4),
  //       child: Image.asset("assets/icons/$iconName.png", width: 16, height: 16,),
  //     ),
  //   );
  // }

  pickItem({required String name}){
    return Column(
      children: [
        GestureDetector(
          onTap: (){

          },
          child: Image.asset('assets/images/$name.png', width: context.width/5
          // 80, height: 80,
          ),
        ),
        Text(tr(name), style: FontFamily().medium.copyWith(fontSize: context.locale.languageCode == 'en'?14:12),),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/logo_icon.png", width: 58, height: 58,),
                    Image.asset("assets/images/logo_text.png", width: 58, height: 58,),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: ()=>context.pushNamed(RouteName.language),
                      child: MyIcon(iconName: 'search')
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                        // onTap: ()=>context.pushNamed(RouteName.language),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneNumberPage()));
                      },
                        child: MyIcon(iconName: 'notification')
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                        onTap: ()=>context.pushNamed(RouteName.language),
                        child: MyIcon(iconName: 'setting')
                    ),
                  ],
                )

              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png",),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24,),
                  ProgressIndicatorView(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/anims/l_arrow.json", width: 50, height: 50,),
                      // Image.asset('assets/anims/arrow_left.png', width: 50, height: 50,),
                      Text(tr('top_pick'), style: FontFamily().bold,),
                      Lottie.asset("assets/anims/l_arrow.json", width: 50, height: 50,),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        pickItem(name: 'vocabulary'),
                        SizedBox(width: 10,),
                        pickItem(name: 'poems'),
                        SizedBox(width: 10,),
                        pickItem(name: 'stories'),
                        SizedBox(width: 10,),
                        pickItem(name: 'songs'),
                      ],
                    ).pad(left: 16, right: 16),
                  ),
                  SizedBox(height: 20,),
                  LessonsView()
                ],
              ),
            ),
          ),
        ));
  }
}
