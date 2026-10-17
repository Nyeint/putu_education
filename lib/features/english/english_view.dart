// Path: english/english_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/features/topics/presentation/pages/poemtory/poemtory_list_view.dart';
import 'package:putu_education/features/widgets/sub_item_widget.dart';
import 'package:putu_education/route/my_router.dart';
import '../../app/config/font_family.dart';
import '../../app/utils/en_types.dart';
import '../topics/presentation/pages/math/math_view.dart';
import '../widgets/my_appbar.dart';

class EnglishView extends StatefulWidget {
  const EnglishView({super.key});

  @override
  State<EnglishView> createState() => _EnglishViewState();
}

class _EnglishViewState extends State<EnglishView> {
  @override
  Widget build(BuildContext context) {
    // 2 per row on phones; capped at the original 170 on wider screens.
    final itemWidth = ((context.width - 20 - 12) / 2).floorToDouble().clamp(0.0, 170.0);
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: 'English',
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
                      "Hey, friend! Let's Learn together!",
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
              // Lottie.asset("assets/anims/bird.json", width: context.width / 4.5),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  SubItemWidget(
                      width: itemWidth,
                      title: 'Numbers',
                      iconName: 'category_number',
                    onTap: (){
                     try{
                       context.pushNamed(RouteName.englishNumber);
                     }catch(e){
                     }
                    },
                      // goTo: RouteName.englishNumber
                  ),
                  SubItemWidget(
                      width: itemWidth,
                      title: 'Alphabets',
                      iconName: 'category_en_alphabet',
                      onTap: (){
                        context.pushNamed(RouteName.englishAlphabet);
                      },
                  ),
                  SubItemWidget(
                      width: itemWidth,
                      title: 'Vocabulary',
                      iconName: 'category_vocabulary',
                      onTap: (){
                        context.pushNamed(RouteName.englishVocabulary);
                      },
                  ),
                  SubItemWidget(
                      width: itemWidth,
                      title: 'Stories',
                      iconName: 'category_story',
                      onTap: (){
                        // context.pushNamed(RouteName.englishNumber);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const PoemToryListView(
                              poemtoryType: 'stories', subject: 'en',
                              title: 'Stories',
                            ))
                        );
                      },
                  ),
                  SubItemWidget(
                      width: itemWidth,
                      title: 'Songs',
                      iconName: 'category_song',
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const PoemToryListView(
                              poemtoryType: 'songs',
                              subject: 'en',
                              title: 'Songs',
                            ))
                        );
                      },
                     ),
                  SubItemWidget(
                      width: itemWidth,
                    title: 'Math', iconName: 'category_math',
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              MathView(
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
