// Path: dashboard/dashboard.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/app/utils/weekly_session_picker.dart';
import 'package:putu_education/data/model/session_item.dart';
import 'package:putu_education/presentation/dashboard/lessons_view.dart';
import 'package:putu_education/presentation/dashboard/progress_indicator.dart';
import 'package:putu_education/presentation/test/phone_number.dart';
import 'package:putu_education/presentation/widgets/my_appbar.dart';
import 'package:putu_education/presentation/widgets/my_icon.dart';
import 'package:putu_education/route/my_router.dart';

import '../../app/config/font_family.dart';
import '../../app/service/locator.dart';
import '../../data/providers/score_provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // Refreshed automatically every week (see WeeklySessionPicker); computed
  // once per screen build cycle so it stays stable while this view is alive.
  late final List<SessionItem> weeklyPicks = WeeklySessionPicker.pick();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // changeStatusBarColor();

  }

  // Future<void> changeStatusBarColor() async {
  //   print("Changing status bar color");
  //   await FlutterStatusbarcolor.setStatusBarColor(
  //       Colors.green,
  //       animate: true);
  // }


  pickItem({required SessionItem item}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => item.onTap(context),
          child: Container(
            width: context.width / 5,
            height: context.width / 5,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: ColorResources.white, width: 3),
              image: DecorationImage(
                image: AssetImage('assets/images/${item.iconName}.png'),
                fit: BoxFit.cover,
              ),
            ),
            // child:  Image.asset('assets/images/${item.iconName}.png',
            //     width: context.width / 5,
            //   // 80, height: 80,
            // ),
          ),
        ),
        // GestureDetector(
        //   onTap: () => item.onTap(context),
        //   child: Image.asset('assets/images/${item.iconName}.png',
        //       width: context.width / 5
        //       // 80, height: 80,
        //       ),
        // ),
        Text(
          tr(item.titleKey),
          style: FontFamily().medium.copyWith(
              fontSize: context.locale.languageCode == 'en' ? 14 : 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorResources.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/background.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                MyAppBar(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           Container(
                             padding: EdgeInsets.all(1),
                             margin: EdgeInsets.only(right: 8),
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               // borderRadius: BorderRadius.circular(8),
                               color: ColorResources.secondary,
                             ),
                             child:  Image.asset(
                               "assets/icons/putu_logo.png",
                               width: 58,
                               height: 58,
                             ),
                           ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hi there!',
                                  style: FontFamily().semiBold.copyWith(
                                      fontSize: 15,
                                      color: Color(0xff856B20)),),
                                Text('Let\'s Learn 🎉', style: FontFamily().bold.copyWith(fontSize: 18,
                                    color: Color(0xff563F10)),),

                              ],
                            ),

                            // Image.asset(
                            //   "assets/images/logo_text.png",
                            //   width: 58,
                            //   height: 58,
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            // GestureDetector(
                            //     onTap: () {
                            //       context.pushNamed(RouteName.search);
                            //     },
                            //     child: MyIcon(iconName: 'search')),
                            // SizedBox(
                            //   width: 16,
                            // ),

                            // GestureDetector(
                            //   // onTap: ()=>context.pushNamed(RouteName.language),
                            //     onTap: () {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (context) => PhoneNumberPage()));
                            //     },
                            //     child: MyIcon(iconName: 'notification')),
                            // SizedBox(
                            //   width: 16,
                            // ),
                            GestureDetector(
                                onTap: () {
                                  ScoreProvider scoreProvider = getIt<ScoreProvider>();
                                  scoreProvider.clearScores();
                                  print("Score Provider ${scoreProvider.englishScoreSum}");
                                  context.pushNamed(RouteName.language);
                                },
                                child: MyIcon(iconName: 'setting')),
                          ],
                        )
                      ],
                      // ),
                    )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ProgressIndicatorView(),

                        // GestureDetector(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiStoryService(
                        //     )));
                        //   },
                        //   child: Text("Story Section"),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/anims/l_arrow.json",
                              width: 50,
                              height: 50,
                            ),
                            // Image.asset('assets/anims/arrow_left.png', width: 50, height: 50,),
                            Text(
                              tr('top_pick'),
                              style: FontFamily().bold,
                            ),
                            Lottie.asset(
                              "assets/anims/l_arrow.json",
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),

                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: [
                        //       pickItem(name: 'vocabulary'),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       pickItem(name: 'poems'),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       pickItem(name: 'stories'),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       pickItem(name: 'songs'),
                        //       for (final item in weeklyPicks) ...[
                        //         pickItem(item: item),
                        //         if (item != weeklyPicks.last)
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //       ],
                        //     ],
                        //   ).pad(left: 16, right: 16),
                        // ),
                        
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                               for (final item in weeklyPicks) ...[
                                pickItem(item: item),
                                if (item != weeklyPicks.last)
                                  SizedBox(
                                    width: 10,
                                  ),
                              ],
                            ],
                          ).pad(left: 16, right: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LessonsView()
                      ],
                    ),
                  ),
                ),
              ],
            )
        
        ),
      )
    );
  }
}
