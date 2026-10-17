import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../widgets/go_button.dart';
import '../../../../widgets/item_decoration.dart';
import '../../../../widgets/my_appbar.dart';
import '../../../../widgets/my_icon.dart';

class EnglishAlphabetView extends StatefulWidget {
  const EnglishAlphabetView({super.key});

  @override
  State<EnglishAlphabetView> createState() => _EnglishAlphabetViewState();
}

class _EnglishAlphabetViewState extends State<EnglishAlphabetView> {
  List<String> letterList = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  List<String> pronounceList = ['[eɪ]','[biː]','[siː]','[diː]','[iː]','[ɛf]','[dʒiː]','[eɪtʃ]',
    '[aɪ]','[dʒeɪ]','[keɪ]','[ɛl]','[ɛm]','[ɛn]','[oʊ]','[piː]','[kjuː]','[ar]','[ɛs]','[tiː]','[juː]','[viː]',
    '[dʌbəl.juː]','[ɛks]','[waɪ]','[ziː]'];
  int selectedIndex = 0;
  static const _pageSize = 10;
  int _page = 0;
  int get _pageCount => (letterList.length / _pageSize).ceil();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      bottomNavigationBar: const BannerAdWidget(),
      appBar: MyAppBar(
        titleWithGoBack: 'Alphabets',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/light_background.png",),
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
                        // padding: EdgeInsets.only(top: 32, bottom: 32),
                        // height: 200,
                        height: context.height*0.25,
                        width: context.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.secondary,
                          border: Border.all(
                              color: ColorResources.lightBg,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(20),
        
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('${letterList[selectedIndex]} ${letterList[selectedIndex].toLowerCase()}',
                                style: FontFamily().semiBold.copyWith(fontSize: 70
                              ),),
                              Text(pronounceList[selectedIndex],
                                style: FontFamily().semiBold.copyWith(fontSize: 30
                              ),),
                            ],
                          ),
                        )
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: GestureDetector(
                          onTap: (){
                            _audioPlayer.play(AssetSource('audios/english-alphabet/${letterList[selectedIndex].toLowerCase()}.mp3'));
                          },
                          child: MyIcon(iconName: 'volume',)),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0, // gap between adjacent items
                    runSpacing: 8.0, // gap between lines
                    children:
                    [
                      for (var index = _page * _pageSize;
                          index < min((_page + 1) * _pageSize, letterList.length);
                          index++)
                          GestureDetector(
                          onTap: () async {
                            setState(() {
                              selectedIndex = index;
                            });
                            // await flutterTts.setLanguage("en-US");
                            // // await flutterTts.setVolume(0.9);
                            // await flutterTts.setSpeechRate(0.2);
                            // await flutterTts.setPitch(0.9);
                            //
                            //
                            // await flutterTts.speak(letterList[selectedIndex].toLowerCase());
                            _audioPlayer.play(AssetSource('audios/english-alphabet/${letterList[index].toLowerCase()}.mp3'));
                          },
                          child: Container(
                            width: context.width/5,
                            height: context.width/5,
                            decoration:
                            index==selectedIndex?
                            selectedDecoration(): unselectedDecoration(),
                            child: Center(child:
                            Text(letterList[index],
                              style: FontFamily().bold.copyWith(fontSize:FontSize().twenty
                              ),)
                            ),
                          )
                      ),
                    ],
                  ).pad(bottom: 10)
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
          ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
        ),
      ),
    );
  }
}
