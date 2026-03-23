import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/english/word_result.dart';
import 'package:putu_education/presentation/game/widgets/front_flip_card_item.dart';
import 'package:putu_education/presentation/game/widgets/progress_bar.dart';
import 'package:putu_education/presentation/game/widgets/voice_item.dart';
import '../../../route/route_name.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/item_voice_dialog.dart';
import '../../widgets/my_appbar.dart';
import '../model/question_result.dart';

class EnglishWordGame extends StatefulWidget {
  const EnglishWordGame({super.key});

  @override
  State<EnglishWordGame> createState() => _EnglishWordGameState();
}

class _EnglishWordGameState extends State<EnglishWordGame> {
  List<String> photoList = [
    'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D'
  ];

  // GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  // FlipCardController? _controller;
  bool showNext = false;

  int currentStep=0;
  int totalSteps=20;
  int selectedIndex = -1;
  List<QuestionResultModel> historyList=[];

  @override
  void initState() {
    super.initState();
    speakWord("snail");
    // _controller = FlipCardController();
  }

  setHistoryList({required String result, required String question}){
    QuestionResultModel model = QuestionResultModel(
        result: result,
        question: question
    );
    historyList.add(model);
  }

  speakWord(String word) async {
    await flutterTts.speak(word);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: '${tr('word')} ${tr('game')}',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/game_background.png",),
                  fit: BoxFit.fill)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProgressBarView(currentStep: currentStep, totalSteps: totalSteps),
                SizedBox(height: 24,),
                VoiceItemView(name: 'snail', description: "Choose 'snail'",),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorResources.primary, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ColorResources.lightBg.withOpacity(0.5)
                  ),
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisSpacing: 15, mainAxisSpacing: 15,
                          crossAxisCount: 2
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              selectedIndex=index;
                              setState(() {});
                              // _controller?.toggleCard();
                              // setState(() {
                              //   showNext=true;
                              // });
                            },
                            child:
                            FrontFlipCardItem(image: photoList[index],isSelected: selectedIndex==index,)
                        );
                      }
                  ),
                ),
                SizedBox(height: 20,),
                // if(showNext)
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: (){
                      if(currentStep==7){
                        context.replaceNamed(RouteName.resultView,
                          extra: {'score': 70, 'childWidget': WordResultView(historyList: historyList,)},);
                      }

                      setHistoryList(
                          result: photoList[selectedIndex],
                          question: "Choose 'snail'");
                      setState(() {
                        currentStep++;
                        selectedIndex = -1;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                        decoration: selectedTabDecoration(),
                        child: currentStep==7?Text(tr('check')):
                        SvgPicture.asset("assets/icons/next.svg")
                    ),
                  ),
                ),
              ],
            ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
          ),
        ),
      ),
    );
  }
}
