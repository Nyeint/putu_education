import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app/config/config.dart';

class ExampleItem extends StatelessWidget {
  BuildContext context;
  String firstTens;
  String firstOnes;
  String secondTens;
  String secondOnes;
  String thirdTens;
  String thirdOnes;
  bool isLine;

  ExampleItem({super.key,
    required this.context,
    required this.firstTens, required this.firstOnes,
    required this.secondTens, required this.secondOnes,
    required this.thirdTens, required this.thirdOnes, this.isLine=false});

  itemWidget(String tens, String ones, {bool isLine = false}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          color: isLine?null:ColorResources.lightBg,
          child: Text(
            context.locale.languageCode == 'en'?
            tens:tens.burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),),
        ),
        Container(
          padding: EdgeInsets.all(5),
          color: isLine?null:ColorResources.secondary,
          child: Text(
            context.locale.languageCode == 'en'?
            ones:ones.burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10,top: 5, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: ColorResources.lightBg
              ),
              child: Text(tr('tens'), style: FontFamily().regular),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10,top: 5, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: ColorResources.secondary
              ),
              child: Text(tr('ones'), style: FontFamily().regular),
            )
          ],
        ),
        SizedBox(height: 10,),
        itemWidget(firstTens, firstOnes),
        itemWidget(secondTens, secondOnes),
        Container(
            height: 2,
            color: Colors.black,
            padding: EdgeInsets.only(left: 15, right: 15),
            child:  itemWidget(' ', ' ', isLine: true)
        ),
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: itemWidget(thirdTens, thirdOnes)
        ),
      ],
    );
  }
}
