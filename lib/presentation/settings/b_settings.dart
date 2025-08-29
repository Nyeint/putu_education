import 'package:flutter/material.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import '../../app/config/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../app/config/config.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // BannerAd? _bannerAd;
  bool _isLoaded = false;

  Widget settingsItem({required IconData icon, required Widget widget1, Widget? widget2}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(icon),
              const SizedBox(width: 10,),
              Expanded(child: widget1),
              const SizedBox(width: 16),
            ],
          ),
        ),
        // const SizedBox(width: 20,),
        widget2??Container(),
        const SizedBox(width: 16,),
      ],
    ).pad(top: 15, bottom: 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: _isLoaded?
      // SizedBox(
      //   height: _bannerAd!.size.height.toDouble(),
      //   width: _bannerAd!.size.width.toDouble(),
      //   child: AdWidget(
      //       ad:_bannerAd!
      //   ),
      // )
      //     :null,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text(tr('settings')[0].toUpperCase() + tr('settings').substring(1), style: FontFamily().semiBold.copyWith(fontSize: 20),),
          const SizedBox(height: 25,),
          Expanded(
            child: ListView(
              children: [
                Card(
                  surfaceTintColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      settingsItem(
                          icon: Icons.share,
                          widget1: Text(tr('share_app')),
                          widget2: const Icon(Icons.keyboard_arrow_right)
                      ),
                      const Divider(height: 0,),
                      const Divider(height: 0,),
                      settingsItem(
                        icon: Icons.language,
                        widget1: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('language')),
                            Text(context.locale.languageCode == 'en'?tr('english'):tr('myanmar'), style: FontFamily().medium.copyWith(fontSize: 13, color: ColorResources.itemSecondary),),
                          ],
                        ),
                        widget2: Switch(
                          value: context.locale.languageCode == 'en',
                          activeColor: ColorResources.white,
                          activeTrackColor: ColorResources.primary,
                          inactiveThumbColor: ColorResources.white,
                          inactiveTrackColor: ColorResources.mute,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool value) {
                            if(!value){
                              context.setLocale(const Locale('my', 'MM'));
                              // Provider.of<SettingsInfoProvider>(context, listen: false).language = Language.mm;
                            }else{
                              context.setLocale(const Locale('en', 'US'));
                              // Provider.of<SettingsInfoProvider>(context, listen: false).language = Language.en;
                            }
                          },
                        ),
                      ),
                      const Divider(height: 0,),
                      const Divider(height: 0,),
                      settingsItem(
                        icon: Icons.update,
                        widget1: const Text('V1.0.1'),
                      ),
                      // Divider(height: 0,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ).pad(left: 20, right: 20),
    );
  }
}
