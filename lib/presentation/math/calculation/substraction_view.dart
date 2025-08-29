import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/presentation/math/calculation/widgets/example_item.dart';
import '../../../app/config/config.dart';

class SubstractionView extends StatelessWidget {
  const SubstractionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorResources.stroke),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExampleItem(
                context: context,
                  firstTens: '2', firstOnes: '3', secondTens: '5', secondOnes: '6', thirdTens: '7', thirdOnes: '9'),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(tr('answer'), style: FontFamily().regular),
              ),
            ],
          ),
        ),
        SizedBox(height: 24,),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.lightBg
          ),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(context.locale.languageCode == 'en'?'5':'5'.burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text('-', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text(context.locale.languageCode == 'en'?index.toString():index.toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text('=', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text(context.locale.languageCode == 'en'?(5-index).toString():(5-index).toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
        SizedBox(height: 24,),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorResources.lightBg
          ),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(context.locale.languageCode == 'en'?(9-index).toString():(9-index).toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text('-', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text(context.locale.languageCode == 'en'?(index+1).toString():(index+1).toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text('=', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                        Text(context.locale.languageCode == 'en'?'8':'8'.burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
        SizedBox(height: 24,)
      ],
    );
  }
}
