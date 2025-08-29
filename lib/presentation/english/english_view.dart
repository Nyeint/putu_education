import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/color_resources.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import 'package:putu_education/presentation/widgets/sub_item_widget.dart';
import 'package:putu_education/route/my_router.dart';
import '../../app/config/font_family.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_icon.dart';

class EnglishView extends StatefulWidget {
  const EnglishView({super.key});

  @override
  State<EnglishView> createState() => _EnglishViewState();
}

class _EnglishViewState extends State<EnglishView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: tr('english'),
            // widget: Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     Align(
            //         alignment: Alignment.centerLeft,
            //         child: GestureDetector(
            //             onTap: ()=>context.pop(),
            //             child: MyIcon(iconName: 'back'))
            //     ),
            //     Center(child:
            //     Text(tr('english'),
            //       style: FontFamily().medium.copyWith(fontSize: context.locale.languageCode == 'en'?24:22), maxLines: 1,))
            //   ],
            // ),
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
                      Lottie.asset("assets/anims/l_arrow.json", width: 50, height: 50,),
                      Flexible(child: Text(tr('learn_together'), style: FontFamily().semiBold,)),
                      Lottie.asset("assets/anims/r_arrow.json", width: 50, height: 50,),
                    ],
                  ),
                  Lottie.asset("assets/anims/bird.json", width: context.width/4.5),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SubItemWidget(
                          title: tr('numbers'), iconName: 'numbers', goTo: RouteName.englishNumber),
                      // SizedBox(width: 16,),
                      SubItemWidget(
                          title: tr('alphabets'), iconName: 'alpha', goTo: RouteName.englishAlphabet),
                      // SizedBox(width: 16,),
                      SubItemWidget(
                          title: tr('vocabulary'), iconName: 'vocab', goTo: RouteName.englishVocabulary),
                      SubItemWidget(
                          title: tr('poems'), iconName: 'poem', goTo: RouteName.englishPoem),
                      SubItemWidget(
                          title: tr('stories'), iconName: 'story', goTo: RouteName.englishNumber),
                      SubItemWidget(
                          title: tr('songs'), iconName: 'song', goTo: RouteName.englishNumber),
                    ],
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ).pad(left: 16, right: 16,top: 24),
          ),
        ));
  }
}
