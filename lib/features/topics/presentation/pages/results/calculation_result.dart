// Path: calculate/calculation_result.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../../../game/model/calculate_history.dart';
import '../games/calculate_game.dart';
import '../../../../game/math/calculate/digit_plus_minus.dart';
import '../../../../game/math/calculate/icon_mul_div.dart';
import '../../../../game/math/calculate/icon_plus_minus.dart';

class CalculationResultView extends StatelessWidget {
  List<CalculateHistoryModel> historyList;
  CalculationResultView({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: context.width-32,
        decoration: BoxDecoration(
          color: ColorResources.lightBg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: historyList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context,index){
              CalculateHistoryModel data = historyList[index];
              return
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.start,
                            // // alignment: WrapAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            // direction: Axis.horizontal,
                            // alignment: WrapAlignment.start,
                            children: [
                              // Text(
                              //     '${context.locale.languageCode == 'en'?(index+1).toString():(index+1).toString().burmese()} .',
                              //     style: FontFamily().medium
                              // ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: ColorResources.primary.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.check_rounded, color: ColorResources.math, size: 20),
                              ),
                              SizedBox(width: 10,),
                              // Text(data.type.toString()),
                              data.type==CalculateType.type1 || data.type==CalculateType.type2?
                              DigitPlusMinusView(
                                a: data.data![0],
                                b: data.data![1],
                                c: data.data![2],
                                result: data.result!,
                                type: data.type!,
                                isHistory: true,
                              ):
                              data.type==CalculateType.type7?
                              IconPlusMinusView(
                                fruitOne: data.fruit![0],
                                fruitTwo: data.fruit![1],
                                fruitThree: data.fruit![2],
                                a: data.data![0],
                                b: data.data![1],
                                c: data.data![2],
                                result: data.result,
                                isHistory: true,
                              ):
                                  // Text(data.type.toString())
                              IconsMultiplyDivide(
                                a: data.data![0],
                                b: data.data![1],
                                type: data.type!,
                                fruitOne: data.fruit![0],
                                fruitTwo: data.fruit![1],
                                result: data.result,
                                isHistory: true,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        // Text(data.result.toString(), style: FontFamily().bold.copyWith(color: ColorResources.math),),
                      ],
                    ),
                    if(data!=historyList.last)
                    Divider()
                  ],
                );
            }),
      ),
    );
  }
}
