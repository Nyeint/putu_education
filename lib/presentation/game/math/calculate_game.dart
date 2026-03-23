import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/math/calculate/digit_plus_minus.dart';
import 'package:putu_education/presentation/game/math/calculate/icon_mul_div.dart';
import 'package:putu_education/presentation/game/math/calculate/icon_plus_minus.dart';
import 'package:putu_education/route/my_router.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../model/calculate_history.dart';
import '../widgets/progress_bar.dart';
import '../widgets/voice_item.dart';
import 'calculate/calculation_result.dart';

enum CalculateType{ type1, type2, type3, type4, type5, type6, type7 }

// type1,2= (+-),  type3,4=fruit Multiply Divide, type 5,6=simple Multiply Divide, type7=fruit (+,-)
class MathCalculationGame extends StatefulWidget {
  const MathCalculationGame({super.key});

  @override
  State<MathCalculationGame> createState() => _MathCalculationGameState();
}

class _MathCalculationGameState extends State<MathCalculationGame> {
  int currentStep=0;
  int totalSteps=20;

  List<String> fruitList = ['apple', 'banana', 'grape', 'mango', 'tangerine', 'pineapple', 'strawberry'];
  List<CalculateType> typeList = [
    CalculateType.type1, CalculateType.type1, CalculateType.type1,
    CalculateType.type2, CalculateType.type2, CalculateType.type2,
    CalculateType.type3, CalculateType.type3, CalculateType.type3,
    CalculateType.type4, CalculateType.type4, CalculateType.type4,
    CalculateType.type5, CalculateType.type5, CalculateType.type5,
    CalculateType.type6, CalculateType.type6,
    CalculateType.type7, CalculateType.type7, CalculateType.type7
  ];
  String correctItem = '';
  List<String> resultList = [];
  int answer = 0;
  int rightAnswer = 0;
  int result = 0;
  CalculateType type = CalculateType.type1;
  List<int> optionList=[];

  int a=0;
  int b=0;
  int c=0;
  String fruitOne = '';
  String fruitTwo = '';
  String fruitThree = '';
  List<String> answerList = [];
  List<CalculateHistoryModel> historyList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    threeNumberProblem();
    typeList.shuffle(Random());
    setState(() {});
  }


  threeNumberProblem(){
    a = Random().nextInt(20);
    b = Random().nextInt(10);
    c = Random().nextInt(10);

    if(type==CalculateType.type7){
      fruitList.shuffle(Random());
      List<String> valuesCopy = fruitList.take(3).toList();
      fruitOne = valuesCopy[0];
      fruitTwo=valuesCopy[1];
      fruitThree=valuesCopy[2];
    }
    // optionList.clear();

    if(type==CalculateType.type1 || type==CalculateType.type7){
      rightAnswer = a+b-c;
      print("Here zero $rightAnswer");
      Set<int> tempOptionList = Set();
      tempOptionList.add(rightAnswer);
      while (tempOptionList.length < 4) {
        int randomValue = a+b-c+Random().nextInt(5);
        tempOptionList.add(randomValue);
      }
      while (tempOptionList.length < 5) {
        int randomValue = a+b-c-Random().nextInt(5);
        tempOptionList.add(randomValue);
      }
      optionList.addAll(tempOptionList);
    } else{
      rightAnswer = a;
      print("Here not zero $rightAnswer $a");
      // optionList.add(a);
      //genereate 4 random value between a-10 and a+10
      Set<int> tempOptionList = Set();
      tempOptionList.add(a);
      while (tempOptionList.length < 5) {
        int randomValue = a-10  + Random().nextInt(a+11);
        tempOptionList.add(randomValue+1);
      }
      optionList.addAll(tempOptionList);
    }
    result = a+b-c;
    optionList.shuffle(Random());


    CalculateHistoryModel model = CalculateHistoryModel();
    model.type = type;
    model.data = [a,b,c];
    model.result = result;
    model.fruit = [fruitOne,fruitTwo,fruitThree];
    historyList.add(model);
    setState(() {});
  }

  multiplyDivideProblem(){
    if(type==CalculateType.type3 || type==CalculateType.type4){
      fruitList.shuffle(Random());
      List<String> valuesCopy = fruitList.take(2).toList();
      fruitOne = valuesCopy[0];
      fruitTwo=valuesCopy[1];
    }

    Set<int> tempOptionList = Set();
    if(type==CalculateType.type3 || type==CalculateType.type5){
      a = Random().nextInt(15)+1;
      b = Random().nextInt(15)+1;
      rightAnswer = a*b;

      tempOptionList.add(rightAnswer);
      while (tempOptionList.length < 5) {
        int randomValue = (a* (Random().nextInt(9)+1)).toInt();
        tempOptionList.add(randomValue+1);
      }

    }else{
      a = Random().nextInt(90)+10;
      b = Random().nextInt(9)+1;
      rightAnswer = a~/b;

      tempOptionList.add(rightAnswer);
      while (tempOptionList.length < 5) {
        int randomValue = a~/(Random().nextInt(9)+1);
        tempOptionList.add(randomValue+1);
      }
    }

    optionList.addAll(tempOptionList);
    optionList.shuffle(Random());

    CalculateHistoryModel model = CalculateHistoryModel();
    model.type = type;
    model.data = [a,b,c];
    model.result = rightAnswer;
    model.fruit = [fruitOne,fruitTwo,fruitThree];
    historyList.add(model);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: '${tr('calculate')} ${tr('game')}',
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
          child: Column(
            children: [
              ProgressBarView(currentStep: currentStep, totalSteps: totalSteps),
              SizedBox(height: 24,),
              VoiceItemView(name: correctItem, description: "What is  '?'",),
              SizedBox(height: 40,),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.primary, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorResources.lightBg.withOpacity(0.5)
                ),
                child:
                    // if(type==CalculateType.type1 || type==CalculateType.type2)
                type==CalculateType.type1 || type==CalculateType.type2?
                    DigitPlusMinusView(a: a, b: b, c: c, result: result, type: type)
                    :
                    type==CalculateType.type7?
                       IconPlusMinusView(fruitOne: fruitOne, fruitTwo: fruitTwo, fruitThree: fruitThree, a: a, b: b, c: c) // type 7
                        :
                       IconsMultiplyDivide(fruitOne: fruitOne, fruitTwo: fruitTwo, a: a, b: b, type: type) // type 3,4,5,6
              ),

              SizedBox(height: 40,),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: optionList.asMap().entries.map((e) {
                        // int index = e.key;
                        // String value = e.value;
                        return GestureDetector(
                          onTap: (){
                            answer = e.value;
                            print("Evalue is ${e.value} and ${e.key} $answer and $rightAnswer");
                            // int rightAnswerCount = resultList.where((char) => char == correctItem).length;
                            if(answer==rightAnswer){
                              print("You are right");
                            }else{
                              print("You are wrong");
                            }
                            setState(() {});
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            decoration: optionList.indexOf(answer)==e.key?selectedDecoration():unselectedDecoration(),
                            child: Text(
                              context.locale.languageCode == 'en'?e.value.toString():e.value.toString().burmese(),
                              style:  FontFamily().medium.copyWith(fontSize: FontSize().twenty),
                            ),
                          ),
                        );
                      }).toList()
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    // if(currentStep==7){
                    //   context.replaceNamed(RouteName.resultView,extra: historyList);
                    // }
                    if(currentStep==7){
                      context.replaceNamed(RouteName.resultView,
                        extra: {'score': 70, 'childWidget': CalculationResultView(historyList: historyList,)},);
                    }
                    optionList.clear();
                    currentStep++;
                    answer=0;
                    type=typeList[currentStep];
                    if(type == CalculateType.type1 || type==CalculateType.type2 || type==CalculateType.type7){
                      threeNumberProblem();
                    }else{
                      multiplyDivideProblem();
                    }
                    historyList.forEach((element) {print("HELLO THIS IS ${element.toJson()}");});
                    // print("HELOOO THIS IS ${historyList[0].toJson()}");
                    setState(() {});

                    // quitAlert(context);
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                      decoration: selectedTabDecoration(),
                      child:
                      currentStep==7?Text(tr('check')):
                      SvgPicture.asset("assets/icons/next.svg")
                  ),
                ),
              ).pad(bottom: 80),
            ],
          ).pad(left: 16, right: 16, top: 24, bottom: 24),
        ),
      ),
    );
  }
}
