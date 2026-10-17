// Path: alphabet/burmese_alphabet_view.dart
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../widgets/go_button.dart';
import '../../../../widgets/item_decoration.dart';
import '../../../../widgets/my_appbar.dart';
import '../../../../widgets/my_icon.dart';

class MyanmarAlphabetView extends StatefulWidget {
  const MyanmarAlphabetView({super.key});

  @override
  State<MyanmarAlphabetView> createState() => _MyanmarAlphabetViewState();
}

class _MyanmarAlphabetViewState extends State<MyanmarAlphabetView> {
  List<String> letterList = ['က','ခ','ဂ','ဃ','င','စ','ဆ','ဇ','ဈ','ည','ဋ','ဌ',
    'ဍ','ဎ','ဏ','တ','ထ','ဒ','ဓ','န','ပ','ဖ','ဗ','ဘ','မ','ယ','ရ','လ','ဝ','သ','ဟ','ဠ','အ'];
  List<String> pronounceList = ['ကကြီး','ခခွေး','ဂငယ်','ဃကြီး','င','စလုံး','ဆလိမ်','ဇကွဲ','ဈမြဉ်ဆွဲ','ညကြီး','ဋသန်းလင်းချိတ်','ဌဝမ်းဘဲ',
    'ဍရင်ကောက်','ဎရင်မှုတ်','ဏကြီး','တဝမ်းပူ','ထဆင်ထူး','ဒဒွေး','ဓအောက်ခြိုက်','နငယ်','ပစောက်','ဖဦးထုပ်','ဗထက်ခြိုက်','ဘကုန်း','မ',
    'ယပက်လက်','ရကောက်','လငယ်','ဝ','သ','ဟ','ဠကြီး','အ'];
  int selectedIndex = 0;
  static const _pageSize = 11;
  int _page = 0;
  int get _pageCount => (letterList.length / _pageSize).ceil();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _play(int index) =>
      _audioPlayer.play(AssetSource('audios/burmese-alphabet/${index + 1}.mp3'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      bottomNavigationBar: const BannerAdWidget(),
      appBar: MyAppBar(
        titleWithGoBack: 'အက္ခရာများ',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/light_background.png'),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      // height: 200,
                      height: context.height*0.25,
                      width: context.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.secondary,
                        border: Border.all(color: ColorResources.lightBg, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(letterList[selectedIndex],
                                style: FontFamily().semiBold.copyWith(
                                    fontSize: 70)),
                            Text(pronounceList[selectedIndex],
                                style: FontFamily().semiBold.copyWith(fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: GestureDetector(
                          onTap: () => _play(selectedIndex),
                          child: MyIcon(iconName: 'volume')),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      for (var index = _page * _pageSize;
                          index < min((_page + 1) * _pageSize, letterList.length);
                          index++)
                        GestureDetector(
                          onTap: () {
                            setState(() => selectedIndex = index);
                            _play(index);
                          },
                          child: Container(
                            width: context.width / 5,
                            height: context.width / 5,
                            decoration: index == selectedIndex
                                ? selectedDecoration()
                                : unselectedDecoration(),
                            child: Center(
                              child: Text(letterList[index],
                                  style: FontFamily().bold.copyWith(fontSize: FontSize().twenty)),
                            ),
                          ),
                        ),
                    ],
                  ).pad(bottom: 10),
                ).pad(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _page > 0
                      ? GestureDetector(
                          onTap: () => setState(() => _page--),
                          child: GoButton(isNext: false))
                      : const SizedBox.shrink(),
                  _page < _pageCount - 1
                      ? GestureDetector(
                          onTap: () => setState(() => _page++),
                          child: GoButton(isNext: true))
                      : const SizedBox.shrink(),
                ],
              ).pad(top: 8, bottom: 16),
            ],
          ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom+30),
        ),
      ),
    );
  }
}
