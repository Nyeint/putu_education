import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

class DivisionView extends StatefulWidget {
  const DivisionView({super.key});

  @override
  State<DivisionView> createState() => _DivisionViewState();
}

class _DivisionViewState extends State<DivisionView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24,),
        Container(
          width: context.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorResources.stroke),
          ),
          child: SvgPicture.asset("assets/images/division_one.svg", width: context.width*0.5,),
        ),
        SizedBox(height: 24,),
        Container(
          width: context.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorResources.stroke),
          ),
          child: SvgPicture.asset("assets/images/division_two.svg", width: context.width*0.6,),
        ),
        SizedBox(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Divident', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
            Text('/', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
            Text('Divisor', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
            Text('=', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
            Text('Quotient', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
          ],
        ),
        SizedBox(height: 10,),
        Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.lightBg
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        physics: ScrollPhysics(),
                        itemBuilder: (context,index1){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text((context.locale.languageCode == 'en'?((index*5)+10).toString():((index*5)+10).toString().burmese()), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Text('/', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Text(context.locale.languageCode == 'en'?(index1+1).toString():(index1+1).toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Text('=', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Text(context.locale.languageCode == 'en'?(((index*5)+10)~/(index1+1)).toInt().toString():(((index*5)+10)~/(index1+1)).toInt().toString().burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                            ],
                          );
                        }
                    ),
                  ).pad(bottom: 24);
                }),
          ],
        ),
        SizedBox(height: 24,)
      ],
    );
  }
}

