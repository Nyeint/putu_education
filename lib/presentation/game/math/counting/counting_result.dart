import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../model/question_result.dart';

class CountingResultView extends StatelessWidget {
  List<QuestionResultModel> historyList;
  CountingResultView({super.key, required this.historyList});

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
              QuestionResultModel data = historyList[index];
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
                              Text(data.question!),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(context.locale.languageCode == 'en'?data.result.toString():data.result.toString().burmese(), style: FontFamily().bold.copyWith(color: ColorResources.math),),
                        // Text("HELKE", style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),),
                        // Text("HELKE", style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),),
                        // Text("HELKE", style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),),
                        // Text("HELKE", style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),)
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
