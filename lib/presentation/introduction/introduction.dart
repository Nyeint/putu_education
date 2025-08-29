import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import 'package:putu_education/route/my_router.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  int currentIndex = 0;
  List<String> titleList = ['Easy Learning','Listen & Learn', 'Playing Game'];
  List<String> descriptionList = ['Kids can easily learn English, Myanmar and Mathematics with phone.',
  'Kids can listen stories, poems, songs and have fun time.',
  'Kids can play English games, Myanmar games and Mathematics games.'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                  // SvgPicture.asset("assets/icons/$iconName.svg", width: 16, height: 16, color: color,),
                  AssetImage("assets/images/${currentIndex==1?'intro_two':currentIndex==2?'intro_three':'intro_one'}.png",),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
              width: context.width,
              height: context.height,
              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/logo.png', width: context.width*0.2),
                      SizedBox(height: 30,),
                      Container(
                          width: context.width*0.8,
                          height: context.width*0.14,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorResources.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // padding: EdgeInsets.only(left: 77, right: 77, t),
                          child: Text(titleList[currentIndex], style: FontFamily().bold.copyWith(fontSize: FontSize().twentyFour,),
                          )),
                      SizedBox(height: 12,),
                      Text(descriptionList[currentIndex],
                        style: FontFamily().regular.copyWith(fontSize: FontSize().eighteen), textAlign: TextAlign.center,)
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(currentIndex<2){
                            setState(() {
                              currentIndex++;
                            });
                          } else{
                            context.goNamed(RouteName.dashboard);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 25, right: 25,top: 5, bottom: 5),
                          decoration: selectedTabDecoration(),
                          child: SvgPicture.asset("assets/icons/next.svg",)
                        )
                        // MyIcon(iconName: 'next', color: ColorResources.primary, padding: 10,),
                      ),
                      SizedBox(height: 16,),
                      GestureDetector(
                        onTap: ()=>context.goNamed(RouteName.dashboard),
                          child: Text('Skip', style: FontFamily().medium.copyWith(decoration: TextDecoration.underline),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
