import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/single_child_widget.dart';
import 'package:putu_education/app/config/config.dart';

import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/my_icon.dart';

class EnglishAlphabetView extends StatefulWidget {
  const EnglishAlphabetView({super.key});

  @override
  State<EnglishAlphabetView> createState() => _EnglishAlphabetViewState();
}

class _EnglishAlphabetViewState extends State<EnglishAlphabetView> {
  late FlutterTts flutterTts;
  List<String> letterList = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  List<String> pronounceList = ['a/eɪ/','bee/biː/','cee/siː/','dee/diː/','e/iː/','ef/ɛf/','gee/dʒiː/','(h)aitch/(h)eɪtʃ/',
    'i/aɪ/','jay/dʒeɪ/','kay/keɪ/','el/ɛl/','em/ɛm/','en/ɛn/','o/oʊ/','pee/piː/','cue/kjuː/','ar/ɑːr/','ess/ɛs/','tee/tiː/','u/juː','vee/viː/',
    'double-u/ˈdʌbəl.juː/','ex/ɛks/','wy/waɪ/','zee/zed/zi/zɛd/'];
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTts();
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: tr('alphabets'),
          ),
          body: Container(
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
                          height: 200,
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
                                Text('${letterList[selectedIndex]} ${letterList[selectedIndex].toLowerCase()}', style: FontFamily().semiBold.copyWith(fontSize: FontSize().sixteenFour
                                ),),
                                Text(pronounceList[selectedIndex], style: FontFamily().semiBold.copyWith(fontSize: FontSize().twentyFour
                                ),),
                              ],
                            ),
                          )
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: GestureDetector(
                            onTap: () async => await flutterTts.speak(letterList[selectedIndex]),
                            child: MyIcon(iconName: 'volume',)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      // height: context.height-200,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0, // gap between adjacent items
                        runSpacing: 8.0, // gap between lines
                        children:
                        List.generate(
                          26,
                              (index) => GestureDetector(
                              onTap: () async {
                                setState(() {
                                  selectedIndex = index;
                                });
                                // await flutterTts.setLanguage("en-US");
                                // await flutterTts.setVolume(0.9);
                                // await flutterTts.setSpeechRate(0.4);
                                // await flutterTts.setPitch(0.3);
                                await flutterTts.speak(letterList[selectedIndex]);
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
                        ),
                      ).pad(bottom: 20),
                    )
                  ).pad(top: 32),
                )
              ],
            ).pad(top: 24).pad(left: 16, right: 16)
          ),
        ));
  }
}
