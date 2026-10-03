// Path: counting/counting_result.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../../../game/model/question_result.dart';

class CountingResultView extends StatelessWidget {
  List<QuestionResultModel> historyList;
  CountingResultView({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              QuestionResultModel data = historyList[index];
              return
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ColorResources.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check_rounded, color: ColorResources.math, size: 20),
                        ),
                        // Text(
                        //     '${context.locale.languageCode == 'en'?(index+1).toString():(index+1).toString().burmese()} .',
                        //   style: FontFamily().medium
                        // ),
                        SizedBox(width: 10,),
                        Expanded(child: Text(data.question!)),
                        SizedBox(width: 14,),
                        Text(
                          context.locale.languageCode == 'en'?data.result.toString():data.result.toString().burmese(),
                          style: FontFamily().bold.copyWith(color: ColorResources.math),),
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
