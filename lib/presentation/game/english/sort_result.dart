import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../model/question_result.dart';
import '../widgets/front_flip_card_item.dart';

class SortResultView extends StatelessWidget {
  List<QuestionResultModel> historyList;
  SortResultView({super.key, required this.historyList});

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
                          width: context.width*0.5,
                          child: Wrap(
                            children: [
                              Text(context.locale.languageCode == 'en'?index.toString():index.toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),),
                              SizedBox(width: 20,),
                              Container(
                                  width: context.width*0.27,
                                  height: context.width*0.25,
                                  padding: EdgeInsets.only(left: 10),
                                  child: FrontFlipCardItem(image: data.question,isSelected: false))

                              //
                            ],
                          ),
                        ),
                        Expanded(child: Text(data.result.toString())),
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
