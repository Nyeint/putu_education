// Path: myanmar/myanmar_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/features/myanmar/number/number_view.dart';
import 'package:putu_education/features/widgets/sub_item_widget.dart';
import 'package:putu_education/route/my_router.dart';
import '../../app/config/font_family.dart';
import '../../app/utils/en_types.dart';
import '../math/math_view.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_icon.dart';

class MyanmarView extends StatefulWidget {
  const MyanmarView({super.key});

  @override
  State<MyanmarView> createState() => _MyanmarViewState();
}

class _MyanmarViewState extends State<MyanmarView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorResources.background,
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sub_background.png",),
                fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            MyAppBar(
              titleWithGoBack: 'မြန်မာစာ',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/anims/l_arrow.json", width: 50, height: 50,),
                        Flexible(child: Text('ဟေး သူငယ်ချင်း! အတူတူလေ့လာကြရအောင်!', style: FontFamily().semiBold,)),
                        Lottie.asset("assets/anims/r_arrow.json", width: 50, height: 50,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    // Lottie.asset("assets/anims/bird.json", width: context.width/4.5),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SubItemWidget(
                            title: 'နံပါတ်များ', iconName: 'category_number',
                            onTap: (){
                              context.pushNamed(RouteName.myanmarNumber);
                            },
                        ),
                        // SizedBox(width: 16,),
                        SubItemWidget(
                            title: 'အက္ခရာများ', iconName: 'category_mm_alphabet',
                            onTap: (){
                              context.pushNamed(RouteName.myanmarAlphabet);
                            },
                           ),
                        // SizedBox(width: 16,),
                        SubItemWidget(
                            title: 'ဝေါဟာရ', iconName: 'category_vocabulary',
                            onTap: (){
                              context.pushNamed(RouteName.myanmarVocabulary);
                            },
                            ),
                        SubItemWidget(
                            title: 'ကဗျာများ', iconName: 'category_poem',
                            onTap: (){
                              context.pushNamed(RouteName.englishPoem);
                            },
                          ),
                        SubItemWidget(
                            title: 'ပုံပြင်များ', iconName: 'category_story',
                            onTap: (){
                              context.pushNamed(RouteName.englishNumber);
                            },
                            ),
                        SubItemWidget(
                            title: 'သီချင်းများ', iconName: 'category_song',
                            onTap: (){
                              context.pushNamed(RouteName.englishNumber);
                            },
                        ),
                        SubItemWidget(
                            title: 'သင်္ချာ', iconName: 'category_math',
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>  MathView(
                                    learnLanguageType: LearnLanguageType.mm.name,
                                  ))
                                  );
                            },
                           ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ).pad(left: 10, right: 10,top: 24),
            ),
          ],
        )
      ),
    );
  }
}
