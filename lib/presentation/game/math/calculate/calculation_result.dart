import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../model/calculate_history.dart';
import '../calculate_game.dart';
import 'digit_plus_minus.dart';
import 'icon_mul_div.dart';
import 'icon_plus_minus.dart';

class CalculationResultView extends StatelessWidget {
  List<CalculateHistoryModel> historyList;
  CalculationResultView({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(top: context.width*0.2, bottom: context.width*0.04,left: 16, right: 16),
        width: context.width-32,
        decoration: BoxDecoration(
          color: ColorResources.lightBg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: historyList.length,
            itemBuilder: (context,index){
              CalculateHistoryModel data = historyList[index];
              return
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: context.width*0.7,
                          // color: Colors.amber,
                          child: Wrap(
                            // mainAxisSize: MainAxisSize.min,
                            // direction: Axis.horizontal,
                            // alignment: WrapAlignment.start,
                            children: [
                              Text(context.locale.languageCode == 'en'?index.toString():index.toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),),
                              // Text(data.type.toString()),
                              SizedBox(width: 20,),
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
                                isHistory: true,
                              ): IconsMultiplyDivide(
                                a: data.data![0],
                                b: data.data![1],
                                type: data.type!,
                                fruitOne: data.fruit![0],
                                fruitTwo: data.fruit![1],
                                isHistory: true,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(data.result.toString(), style: FontFamily().bold.copyWith(color: ColorResources.math),),
                      ],
                    ),
                    Divider()
                  ],
                );
            }),
      ),
    );
  }
}
