import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/english/sort_result.dart';
import '../../../route/route_name.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../model/question_result.dart';
import '../widgets/front_flip_card_item.dart';
import '../widgets/progress_bar.dart';
import '../widgets/voice_item.dart';

class EnglishSentenceSortGame extends StatefulWidget {
  const EnglishSentenceSortGame({super.key});

  @override
  State<EnglishSentenceSortGame> createState() => _EnglishSentenceSortGameState();
}

class _EnglishSentenceSortGameState extends State<EnglishSentenceSortGame> {
  int currentStep=1;
  int totalSteps=0;

  List<String> photoList = [
    'https://www.shutterstock.com/image-photo/cat-under-table-260nw-494788639.jpg',
    'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D'
  ];

  List<String> nameList = ['A\ncat\nis\nunder\nthe\ntable','there\n is \na \nsquirrel \non \nthe tree','a \nhorse \nis \nrunning','elephant \nis \nso \nbig'];
  List<String> characterList = [];
  Set<int> selectedIndices = Set<int>();
  List<String> answer = [];
  bool showNext = false;
  List<QuestionResultModel> historyList=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    characterList = nameList[0].split('\n').toList();
    characterList.shuffle(Random());
    totalSteps = photoList.length;
    setState(() {});
  }

  setHistoryList({required String result, required String question}){
    QuestionResultModel model = QuestionResultModel(
        result: result,
        question: question
    );
    historyList.add(model);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            titleWithGoBack: '${tr('sentence_sort')} ${tr('game')}',
          ),
          body: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/game_background.png",),
                    fit: BoxFit.cover)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProgressBarView(currentStep: currentStep, totalSteps: totalSteps),
                  SizedBox(height: 24,),
                  VoiceItemView(name: nameList[currentStep-1], description: 'Fill the blank',),
                  SizedBox(height: 40,),
                  SizedBox(
                      width: context.width*0.45,
                      height: context.width*0.45,
                      child: FrontFlipCardItem(image: photoList[currentStep-1], isSelected: true,),
                  ),
                  SizedBox(height: 30,),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...answer.map((e) {
                        return  Text(
                          e,
                          style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                        );
                      }),
                      ...List.generate(
                        characterList.length - answer.length,
                            (index) => Text(
                          '_',
                          style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: characterList.asMap().entries.map((e) {
                        int index = e.key;
                        String value = e.value;
                        return GestureDetector(
                          onTap: (){
                            if (selectedIndices.contains(index)) {
                              selectedIndices.remove(index);
                              answer.remove(characterList[index]);
                            } else {
                              selectedIndices.add(index);
                              answer.add(characterList[index]);
                            }
                            if(answer.length == characterList.length){
                              showNext = true;
                            } else{
                              showNext=false;
                            }
                            setState(() {});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width * 0.2,
                                padding: EdgeInsets.only(left: 30, right: 30),
                                height: MediaQuery.of(context).size.width * 0.15,
                                alignment: Alignment.center,
                                decoration: selectedIndices.contains(index)?selectedDecoration():unselectedDecoration(),
                                child: Text(
                                  value,
                                  style:  FontFamily().medium.copyWith(fontSize: FontSize().twenty),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList()
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: (){
                        if(currentStep==4){
                          context.replaceNamed(RouteName.resultView,
                            extra: {'score': 70, 'childWidget': SortResultView(historyList: historyList,)},);
                        }

                        setHistoryList(
                            result: answer.join(''),
                            question: photoList[currentStep-1]);

                        currentStep++;
                        // characterList = nameList[currentStep-1].split('').toList();
                        // characterList.shuffle(Random());
                        showNext=false;
                        selectedIndices.clear();
                        answer.clear();
                        setState(() {});

                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                          decoration: answer.length == characterList.length?selectedDecoration():unselectedDecoration(),
                          // selectedTabDecoration(),
                          child:
                          currentStep==photoList.length?Text(tr('check'),style: FontFamily().medium,):SvgPicture.asset("assets/icons/next.svg")
                      ),
                    ),
                  ),
                ],
              ).pad(left: 16, right: 16, top: 24, bottom: 24),
            ),
          ),
        ));
  }
}
