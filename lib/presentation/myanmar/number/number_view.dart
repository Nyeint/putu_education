import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/go_button.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import 'package:putu_education/presentation/widgets/my_appbar.dart';
import '../../../app/service/tts_service.dart';
import '../../widgets/my_icon.dart';

class MyanmarNumberView extends StatefulWidget {
  const MyanmarNumberView({super.key});

  @override
  State<MyanmarNumberView> createState() => _MyanmarNumberViewState();
}

class _MyanmarNumberViewState extends State<MyanmarNumberView> {
  // late FlutterTts flutterTts;
  FlutterTts flutterTts = TtsService.instance.flutterTts;
  int currentPage=1;
  int lastPage=10;
  List<int> numberList = [];
  List<String> numberInWord=['One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten',
    'Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Nineteen','Twenty',
    'Twenty one','Twenty two','Twenty three','Twenty four','Twenty five','Twenty six','Twenty seven','Twenty eight','Twenty nine','Thirty',
    'Thirty one','Thirty two','Thirty three','Thirty four','Thirty five','Thirty six','Thirty seven','Thirty eight','Thirty nine','Forty',
    'Forty one','Forty two','Forty three','Forty four','Forty five','Forty six','Forty seven','Forty eight','Forty nine','Fifty',
    'Fifty one','Fifty two','Fifty three','Fifty four','Fifty five','Fifty six','Fifty seven','Fifty eight','Fifty nine','Sixty',
    'Sixty one','Sixty two','Sixty three','Sixty four','Sixty five','Sixty six','Sixty seven','Sixty eight','Sixty nine','Seventy',
    'Seventy one','Seventy two','Seventy three','Seventy four','Seventy five','Seventy six','Seventy seven','Seventy eight','Seventy nine','Eighty',
    'Eighty one','Eighty two','Eighty three','Eighty four','Eighty five','Eighty six','Eighty seven','Eighty eight','Eighty nine','Ninety',
    'Ninety one','Ninety two','Ninety three','Ninety four','Ninety five','Ninety six','Ninety seven','Ninety eight','Ninety nine','One hundred',];
  int selectedNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initTts();
    numberList = List.generate(100, (index) => index + 1);
  }

  // Future _setAwaitOptions() async {
  //   await flutterTts.awaitSpeakCompletion(true);
  // }
  //
  // initTts() {
  //   flutterTts = FlutterTts();
  //   _setAwaitOptions();
  // }

  // String convertToBurmeseNumerals(String number) {
  //   Map<String, String> numeralMap = {
  //     '0': '၀',
  //     '1': '၁',
  //     '2': '၂',
  //     '3': '၃',
  //     '4': '၄',
  //     '5': '၅',
  //     '6': '၆',
  //     '7': '၇',
  //     '8': '၈',
  //     '9': '၉'
  //   };
  //
  //   // Convert each character in the number string using the map
  //   String burmeseNumber = number.split('').map((char) {
  //     return numeralMap[char] ?? char;
  //   }).join('');
  //
  //   return burmeseNumber;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: tr('english'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/light_background.png",),
                  fit: BoxFit.fill),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 32, bottom: 32),
                              width: context.width,
                              decoration: BoxDecoration(
                                color: ColorResources.secondary,
                                border: Border.all(
                                    color: ColorResources.lightBg,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Column(
                                children: [
                                  Text(selectedNumber.toString().burmese(), style: FontFamily().semiBold.copyWith(fontSize: FontSize().sixteenFour
                                  ),),
                                  Text(numberInWord[selectedNumber-1], style: FontFamily().semiBold.copyWith(fontSize: FontSize().twentyFour
                                  ),),
                                ],
                              )
                            ),
                            Positioned(
                              right: 16,
                              top: 16,
                              child: GestureDetector(
                                onTap: () async => await flutterTts.speak(selectedNumber.toString()),
                                  child: MyIcon(iconName: 'volume',)),
                            )
                          ],
                        ).pad(bottom: 32),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0, // gap between adjacent items
                          runSpacing: 8.0, // gap between lines
                          children: List.generate(
                            10,
                                (index) => GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    selectedNumber = ((currentPage-1)*10+index)+1;
                                  });
                                  // await flutterTts.setLanguage("en-US");
                                  // await flutterTts.setVolume(0.9);
                                  // await flutterTts.setSpeechRate(0.4);
                                  // await flutterTts.setPitch(0.3);
                                  await flutterTts.speak(selectedNumber.toString());
                                },
                                child: Container(
                                  width: context.width/5,
                                  height: context.width/5,
                                  decoration:
                                  ((currentPage-1)*10+index)+1==selectedNumber?
                                  selectedDecoration(): unselectedDecoration(),
                                  child: Center(child:
                                  Text( (((currentPage-1)*10+index)+1).toString().burmese(),
                                    style: FontFamily().bold.copyWith(fontSize:FontSize().twenty
                                    ),)
                                  ),
                                )
                            ),
                          ),
                        )
                      ],
                    ).pad(bottom: 20, top: 24),
                  ).pad(bottom: context.width/7.5+20),
                ),
                if(currentPage>1)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage--;
                          selectedNumber = ((currentPage-1)*10+1).toInt();
                        });
                      },
                      child: GoButton(isNext: false),
                  ).pad(bottom: 10),
                ),
                if(currentPage<=lastPage)
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentPage++;
                          selectedNumber = ((currentPage-1)*10+1).toInt();
                        });
                      },
                      child: GoButton(isNext: true),
                  ).pad(bottom: 10),
                )
              ],
            ).pad(left: 16, right: 16),
          ),
        ));
  }
}