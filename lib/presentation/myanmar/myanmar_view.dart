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
              titleWithGoBack: tr('myanmar'),
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
                            title: tr('numbers'), iconName: 'mm_number', goTo: RouteName.myanmarNumber),
                        // SizedBox(width: 16,),
                        SubItemWidget(
                            title: tr('alphabets'), iconName: 'mm_alpha', goTo: RouteName.myanmarAlphabet),
                        // SizedBox(width: 16,),
                        SubItemWidget(
                            title: tr('vocabulary'), iconName: 'mm_vocab', goTo: RouteName.englishVocabulary),
                        SubItemWidget(
                            title: tr('poems'), iconName: 'mm_poem', goTo: RouteName.englishPoem),
                        SubItemWidget(
                            title: tr('stories'), iconName: 'mm_story', goTo: RouteName.englishNumber),
                        SubItemWidget(
                            title: tr('songs'), iconName: 'mm_song', goTo: RouteName.englishNumber),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ).pad(left: 16, right: 16,top: 24),
            ),
          ],
        )
      ),
    );
  }
}
