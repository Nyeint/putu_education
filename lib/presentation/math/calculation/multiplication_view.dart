import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

class MultiplicationView extends StatefulWidget {
  String? locale;
  MultiplicationView({super.key, required this.locale});

  @override
  State<MultiplicationView> createState() => _MultiplicationViewState();
}

class _MultiplicationViewState extends State<MultiplicationView> {
  List<int> numberList = [0,5,10,15];
  int selectedNumber = 0;

  Widget tabItem(int number){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedNumber = number;
        });
      },
      child:  Container(
        constraints: BoxConstraints(
            minHeight: 48
        ),
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: selectedNumber==number?
        selectedTabDecoration():unselectedTabDecoration(),
        child: Center(child:
        Text(widget.locale == 'en'?'${number+1} - ${number+5}':'${(number+1).toString().burmese()} - ${(number+5).toString().burmese()}',
          style: FontFamily().medium.copyWith(fontSize:16
            // FontSize.twenty(context)
          ),)
        ),
      ),
    );
  }

  Widget textWidget(String text){
    return Text(widget.locale == 'en'?text:text.burmese(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              const SizedBox(width: 10,),
              tabItem(numberList[0]),
              const SizedBox(width: 10,),
              tabItem(numberList[1]),
              const SizedBox(width: 10,),
              tabItem(numberList[2]),
              const SizedBox(width: 10,),
              tabItem(numberList[3]),
            ],
          ),
        ),
        SizedBox(height: 24,),
        Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
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
                              textWidget((index+1+selectedNumber).toString()),
                              // Text("index+1+selectedNumber).toString()", style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              // Text('*', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Icon(Icons.close, color: Colors.black, size: context.width*0.05,),
                              textWidget(index1.toString()),
                              // Text(index1.toString(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              Text('=', style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
                              textWidget(((index+1+selectedNumber)*index1).toString()),
                              // Text(((index+1+selectedNumber)*index1).toString(), style: FontFamily().medium.copyWith(fontSize: FontSize().twenty)),
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

