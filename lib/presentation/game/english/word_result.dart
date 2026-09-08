// Path: english/word_result.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../model/question_result.dart';

class WordResultView extends StatelessWidget {
  List<QuestionResultModel> historyList;
  WordResultView({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          QuestionResultModel data = historyList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: ColorResources.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
              ],
            ),
            child: Row(
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
                Expanded(
                  child: Text(
                    data.question.toString(),
                    style: FontFamily().bold.copyWith(fontSize: FontSize().sixteen),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: data.result,
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
              ],
            ),
          );
        });
  }
}
