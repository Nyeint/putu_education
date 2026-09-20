// Path: english/sort_result.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../../../game/model/question_result.dart';
import '../../../../game/widgets/front_flip_card_item.dart';

class SortResultView extends StatelessWidget {
  List<QuestionResultModel> historyList;
  SortResultView({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16),
        // padding: EdgeInsets.only(top: context.width*0.2, bottom: context.width*0.04,left: 16, right: 16),
        width: context.width-32,
        decoration: BoxDecoration(
          color: ColorResources.lightBg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
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
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ColorResources.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check_rounded, color: ColorResources.math, size: 20),
                        ),
                        SizedBox(width: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: data.question,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              width: 52,
                              height: 52,
                              color: ColorResources.lightBg,
                              child: Icon(Icons.image, color: ColorResources.icon),
                            ),
                            placeholder: (context, url) => Container(
                              width: 52,
                              height: 52,
                              color: ColorResources.lightBg,
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        // Container(
                        //     width: 100,
                        //     height: 80,
                        //     padding: EdgeInsets.only(left: 10),
                        //     child: FrontFlipCardItem(image: data.question,isSelected: false)),
                        Expanded(child: Text(data.correctAnswer.toString())),
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
