import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/presentation/widgets/sub_item_widget.dart';
import 'package:putu_education/route/my_router.dart';
import '../../app/config/font_family.dart';
import '../../app/utils/en_types.dart';
import '../math/math_view.dart';
import '../widgets/my_appbar.dart';

class EnglishView extends StatefulWidget {
  const EnglishView({super.key});

  @override
  State<EnglishView> createState() => _EnglishViewState();
}

class _EnglishViewState extends State<EnglishView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: tr('english'),
      ),
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/sub_background.png",),
              fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/anims/l_arrow.json",
                    width: 50,
                    height: 50,
                  ),
                  Flexible(
                    child: Text(
                      tr('learn_together'),
                      style: FontFamily().semiBold,
                    ),
                  ),
                  Lottie.asset(
                    "assets/anims/r_arrow.json",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              Lottie.asset("assets/anims/bird.json", width: context.width / 4.5),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SubItemWidget(
                      title: tr('numbers'),
                      iconName: 'category_number',
                    onTap: (){
                     try{
                       context.pushNamed(RouteName.englishNumber);
                     }catch(e){
                        print('Navigation error: $e');
                     }
                    },
                      // goTo: RouteName.englishNumber
                  ),
                  SubItemWidget(
                      title: tr('alphabets'),
                      iconName: 'category_en_alphabet',
                      onTap: (){
                        context.pushNamed(RouteName.englishAlphabet);
                      },
                  ),
                  SubItemWidget(
                      title: tr('vocabulary'),
                      iconName: 'category_vocabulary',
                      onTap: (){
                        context.pushNamed(RouteName.englishVocabulary);
                      },
                  ),
                  SubItemWidget(
                      title: tr('poems'),
                      iconName: 'category_poem',
                      onTap: (){
                        context.pushNamed(RouteName.englishPoem);
                      },
                  ),
                  SubItemWidget(
                      title: tr('stories'),
                      iconName: 'category_story',
                      onTap: (){
                        context.pushNamed(RouteName.englishNumber);
                      },
                  ),
                  SubItemWidget(
                      title: tr('songs'),
                      iconName: 'category_song',
                      onTap: (){
                        context.pushNamed(RouteName.englishNumber);
                      },
                     ),
                  SubItemWidget(
                    title: tr('math'), iconName: 'category_math',
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  MathView(
                            learnLanguageType: LearnLanguageType.en.name,
                          ))
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ).pad(left: 10, right: 10, top: 24),
      ),
    );
  }
}
