import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/presentation/game/math/counting/counting_result.dart';
import '../../../app/config/config.dart';
import '../../../route/route_name.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../model/question_result.dart';
import '../widgets/progress_bar.dart';
import '../widgets/voice_item.dart';

class MathCountingGame extends StatefulWidget {
  const MathCountingGame({super.key});

  @override
  State<MathCountingGame> createState() => _MathCountingGameState();
}

class _MathCountingGameState extends State<MathCountingGame> {
  int currentStep=0;
  int totalSteps=20;

  List<String> shapeList = ['triangle', 'square', 'pentagon', 'hexagon','heptagon','octagon','nonagon','decagon','circle', 'semicircle', 'oval','line','parallelogram'];
  List<String> fruitList = ['apple', 'banana', 'grape', 'mango', 'tangerine', 'pineapple', 'strawberry'];

  String correctItem = '';
  List<String> resultList = [];
  int answer = 0;
  String question = '';
  List<QuestionResultModel> historyList=[];

  List<String> generateRandomCounts(List<String> shapes, int totalCount) {
    List<String> resultList = [];
    Random rand = Random();
    int remainingCount = totalCount;

    while (remainingCount > 0) {
      for (String shape in shapes) {
        if (remainingCount == 0) break;
        int maxCount = min(5, remainingCount);
        int count = rand.nextInt(maxCount) + 1;
        for (int i = 0; i < count; i++) {
          resultList.add(shape);
        }
        remainingCount -= count;
      }
    }
    // Shuffle the final list to randomize the order
    resultList.shuffle();
    return resultList;
  }

  getRandomShapeList(){
    //4 types of shapes and total of 7
    List<String> valuesCopy = List.from(shapeList);
    // Shuffle the list
    valuesCopy.shuffle(Random());
    List<String> result = valuesCopy.take(4).toList();
    correctItem = result[0];

    // Step 2: Generate random counts for each selected shape
    resultList = generateRandomCounts(result, 7);
    // question = 'How many $correctItem are there?';
    question = 'how_many'.tr(args: [tr(correctItem),GlobalContext.navigatorKey.currentContext?.locale.languageCode == 'en'?'':'ခု']);
    setState(() {});
    setHistoryList(result: resultList.where((char) => char == correctItem).length, question: question);
  }

  getRandomFruitList(){
    // 3 types of fruits and total of 7
    List<String> valuesCopy = List.from(fruitList);
    // Shuffle the list
    valuesCopy.shuffle(Random());
    List<String> result = valuesCopy.take(3).toList();
    correctItem = result[0];

    // Step 2: Generate random counts for each selected shape
    resultList = generateRandomCounts(result, 7);
    question = 'how_many'.tr(args: [tr(correctItem),GlobalContext.navigatorKey.currentContext?.locale.languageCode == 'en'?'':'လုံး']);
    setState(() {});
    setHistoryList(result: resultList.where((char) => char == correctItem).length, question: question);
  }

  setHistoryList({required int result, required String question}){
    QuestionResultModel model = QuestionResultModel(
      result: result,
      question: question
    );
    historyList.add(model);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomShapeList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.background,
        appBar: MyAppBar(
          titleWithGoBack: '${tr('counting')} ${tr('game')}',
        ),
        body: Container(
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
                VoiceItemView(name: correctItem, description: question,),
                SizedBox(height: 40,),

                if(resultList.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorResources.primary, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: ColorResources.lightBg.withOpacity(0.5)
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: resultList.asMap().entries.map((e) {
                        return  SvgPicture.asset("assets/icons/${currentStep%2==0?'shapes':'fruits'}/${e.value}.svg",
                          color: currentStep%2==0?ColorResources.primary:null, height: context.width*0.2, width: context.width*0.5,);
                      }).toList(),
                    ),
                  ),

                SizedBox(height: 40,),
                Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [1,2,3,4,5].asMap().entries.map((e) {
                      return GestureDetector(
                        onTap: (){
                          answer = e.value;
                          int rightAnswerCount = resultList.where((char) => char == correctItem).length;
                          if(answer==rightAnswerCount){
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
                          decoration: answer==e.key+1?selectedDecoration():unselectedDecoration(),
                          child: Text(
                            context.locale.languageCode == 'en'?e.value.toString():e.value.toString().burmese(),
                            style:  FontFamily().medium.copyWith(fontSize: FontSize().twenty),
                          ),
                        ),
                      );
                    }).toList()
                ),
                SizedBox(height: 20,),
                // if(showNext)
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: (){
                      if(currentStep==7){
                        context.replaceNamed(RouteName.resultView,
                          extra: {'score': 70, 'childWidget': CountingResultView(historyList: historyList,)},);
                      }

                      currentStep++;
                      answer=0;
                      setState(() {});
                      if(currentStep%2==0){
                        getRandomShapeList();
                      }else{
                        getRandomFruitList();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                        decoration: selectedTabDecoration(),
                        child:
                        currentStep==7?Text(tr('check')):
                        SvgPicture.asset("assets/icons/next.svg")
                    ),
                  ),
                ),
              ],
            ).pad(left: 16, right: 16, top: 24, bottom: 24),
          ),
        ),
      ),

    );
  }
}
