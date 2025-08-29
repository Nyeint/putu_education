import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/math/calculation/addition_view.dart';
import 'package:putu_education/presentation/math/calculation/division_view.dart';
import 'package:putu_education/presentation/math/calculation/substraction_view.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import 'multiplication_view.dart';

class CalculationView extends StatefulWidget {
  const CalculationView({super.key});

  @override
  State<CalculationView> createState() => _CalculationViewState();
}

class _CalculationViewState extends State<CalculationView> {
  int selectedIndex = 0;
  // List<IconData> itemList = [Icons.add, Icons.remove,Icons.close,Icons.percent];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            titleWithGoBack: tr('calculation'),
          ),
          body: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/light_background.png",),
                    fit: BoxFit.cover)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.width/5.5+20,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,index){
                        return
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                                width: context.width/5.3,
                                height: context.width/5.3,
                                padding: EdgeInsets.all(17),
                                decoration: selectedIndex==index?selectedDecoration():unselectedDecoration(),
                                child:
                                    // index==0?
                                // SvgPicture.asset("assets/icons/add.svg", width: 10, height: 10,)
                                
                                
                                SvgPicture.asset("assets/icons/"
                                    "${index==0 && selectedIndex==0?'add_select':index==1 && selectedIndex==1?'substract_select':
                                index==2 && selectedIndex==2?'multiply_select':index==3 && selectedIndex==3?'division _select':
                                    index==0?'add':index==1?'substract':index==2?'multiply':index==3?'division':'add'}.svg"
                                  )
                                // Icon(itemList[index])
                            ).pad(right: context.width*0.04,top: 10, bottom: 10),
                          );
                      }),
                ),
                Expanded(
                    child:
                    SingleChildScrollView(
                        child:
                        selectedIndex==1?
                        SubstractionView():
                        selectedIndex==2?
                        MultiplicationView():
                        selectedIndex==3?
                        DivisionView():AdditionView()
                    )
                )
              ],
            ).pad(left: 16, right: 16,top: 24),
          ),
        ));
  }
}
