import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:putu_education/app/config/config.dart';

import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/my_icon.dart';

class MyanmarAlphabetView extends StatefulWidget {
  const MyanmarAlphabetView({super.key});

  @override
  State<MyanmarAlphabetView> createState() => _MyanmarAlphabetViewState();
}

class _MyanmarAlphabetViewState extends State<MyanmarAlphabetView> {
  final List<String> letterList = [
    'က','ခ','ဂ','ဃ','င','စ','ဆ','ဇ','ဈ','ည','ဋ','ဌ','ဍ','ဎ','ဏ','တ','ထ','ဒ','ဓ','န','ပ','ဖ','ဗ','ဘ','မ','ယ','ရ','လ','ဝ','သ','ဟ','ဠ','အ'
  ];

  final List<String> pronounceList = [
    'ka̰ dʑí','kʰa̰ ɡwé','ɡa̰ ŋɛ̀','ɡa̰ dʑí','ŋa','sa̰ lóʊɰ̃','sʰa̰ lèɪɰ̃','za̰ ɡwɛ́','za̰ mjɪ̀ɰ̃ zwɛ́','ɲa̰ dʑí',
    'ta̰ təlɪ́ɰ̃ dʑeɪʔ','tʰa̰ wʊ́ɰ̃ bɛ́','da̰ jɪ̀ɰ̃ ɡaʊʔ','da̰ jè m̥oʊʔ','na̰ dʑí','ta̰ wʊ́ɰ̃ bù','tʰa̰ sʰɪ̀ɰ̃ dú','da̰ dwé','da̰ ʔaʊʔ tɕʰaɪʔ',
    'na̰ ŋɛ̀','pa̰ zaʊʔ','pʰa̰ ʔóʊʔ tʰoʊʔ','ba̰ tɛʔ tɕʰaɪʔ','ba̰ ɡóʊɰ̃','ma̰','ja̰ pɛʔ lɛʔ','ja̰ ɡaʊ','la̰ ŋɛ̀','wa̰','θa̰','ha̰','la̰ dʑí','ʔa̰'
  ];

  int selectedIndex = 0;
  final AudioPlayer _player = AudioPlayer();

  Future<void> _playIndex(int i) async {
    try {
      // stop any current sound then play the new one
      await _player.stop();
      await _player.setLoopMode(LoopMode.off);
      await _player.setAsset('assets/audios/burmese-alphabet/${i + 1}.mp3');
      await _player.play();
    } catch (e) {
      debugPrint('Audio play error: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: tr('alphabets'),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/light_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  // fit: StackFit.loose,
                  children: [
                    Container(
                      height: 200,
                      width: context.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.secondary,
                        border: Border.all(color: ColorResources.lightBg, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Align(
                            // right: 16,
                            // top: 16,
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () async => _playIndex(selectedIndex),
                              child: MyIcon(iconName: 'volume'),
                            ),
                          ).pad(right: 16, top: 16),
                          Text(
                            letterList[selectedIndex],
                            style: FontFamily().semiBold.copyWith(
                              fontSize: FontSize().sixteenFour,
                            ),
                          ),
                          Text(
                            pronounceList[selectedIndex],
                            style: FontFamily().semiBold.copyWith(
                              fontSize: FontSize().twentyFour,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      letterList.length,
                          (index) => GestureDetector(
                        onTap: () async {
                          setState(() => selectedIndex = index);
                          await _playIndex(index);
                        },
                        child: Container(
                          width: context.width / 5,
                          height: context.width / 5,
                          decoration: index == selectedIndex
                              ? selectedDecoration()
                              : unselectedDecoration(),
                          child: Center(
                            child: Text(
                              letterList[index],
                              style: FontFamily().bold.copyWith(
                                fontSize: FontSize().twenty,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).pad(top: 20),
              ),
            ],
          ).pad(left: 10, right: 10, top: 24, bottom: MediaQuery.of(context).padding.bottom)
        ),
      ),
    );
  }
}
