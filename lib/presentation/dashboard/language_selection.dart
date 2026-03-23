import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:putu_education/app/config/config.dart';

import '../../app/config/font_family.dart';
import '../../data/providers/settings_info_provider.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_icon.dart';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: tr('choose_language'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Image.asset("assets/images/logo_icon.png", width: context.width/3,),
            SizedBox(height: 16,),
            SizedBox(
              height: 70,
              child: Text(tr('which_language'), style: FontFamily().semiBold),
            ),


            GestureDetector(
              onTap: (){
                context.setLocale(const Locale('en', 'US'));
                Provider.of<SettingsInfoProvider>(context, listen: false).language = Language.en;
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.locale.languageCode == 'en'?ColorResources.primary:ColorResources.lightBg,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: context.locale.languageCode == 'en'?[]:[
                    BoxShadow(
                      color: ColorResources.primary,
                      blurRadius: 1.0,
                      spreadRadius: 0.4,
                      offset: Offset(0, 2.0), // bottom shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/english.png", width: 32,),
                        SizedBox(width: 16,),
                        Text('English Language')
                      ],
                    ),
                    if(context.locale.languageCode == 'en')
                    MyIcon(iconName: 'checkmark')
                  ],
                )
              ),
            ),

            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                context.setLocale(const Locale('my', 'MM'));
                Provider.of<SettingsInfoProvider>(context, listen: false).language = Language.mm;
              },
              child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.locale.languageCode == 'en'?ColorResources.lightBg:ColorResources.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: context.locale.languageCode != 'en'?[]:[
                      BoxShadow(
                        color: ColorResources.primary,
                        blurRadius: 1.0,
                        spreadRadius: 0.4,
                        offset: Offset(0, 2.0), // bottom shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/myanmar.png", width: 32,),
                          SizedBox(width: 16,),
                          Text('မြန်မာ ဘာသာစကား')
                        ],
                      ),
                      if(context.locale.languageCode != 'en')
                      MyIcon(iconName: 'checkmark')
                    ],
                  )
              ),
            )

          ],
        ).pad(left: 16, right: 16 ),
      ),
    );
  }
}
