import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/utils/en_types.dart';
import 'package:putu_education/presentation/math/shape/shape_view.dart';

import '../../app/config/config.dart';
import '../../route/route_name.dart';
import '../widgets/my_appbar.dart';
import '../widgets/sub_item_widget.dart';

class MathView extends StatefulWidget {
  String? learnLanguageType;
  MathView({super.key, this.learnLanguageType});

  @override
  State<MathView> createState() => _MathViewState();
}

class _MathViewState extends State<MathView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
      // appBar: MyAppBar(
      //   titleWithGoBack: tr('math'),
      // ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          height: context.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/water_background.png",),
                  fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              MyAppBar(
                titleWithGoBack: tr('math'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/anims/l_arrow.json", width: 50, height: 50,),
                          Flexible(child: Text(tr('learn_together'), style: FontFamily().semiBold,)),
                          Lottie.asset("assets/anims/r_arrow.json", width: 50, height: 50,),
                        ],
                      ),
                      Lottie.asset("assets/anims/fish.json", width: context.width/4.5),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SubItemWidget(
                              title: tr('shapes'), iconName: 'shape',
                          onTap: (){
                                print("shape tap ${widget.learnLanguageType} and ${LearnLanguageType.en.name} and ${LearnLanguageType.mm.name}");

                               try{
                                 Navigator.push(context, MaterialPageRoute(builder: (context){
                                   return ShapeView(
                                     locale: widget.learnLanguageType ?? LearnLanguageType.mm.name,
                                   );
                                 }));
                                 // Navigator.pushNamed(context,
                                 //     widget.learnLanguageType == LearnLanguageType.en.name ?
                                 //     RouteName.shapeViewEn :
                                 //     RouteName.shapeViewMm);
                               }catch(e){
                                  print("shape tap error $e");
                               }
                          },

                          //     goTo:
                          // widget.learnLangaugeType == LearnLanguageType.en.name ?
                          // RouteName.shapeViewEn :
                          // RouteName.shapeViewMm
                          ),
                          SubItemWidget(
                              title: tr('calculation'), iconName: 'calculation',
                              onTap: (){
                                context.pushNamed(RouteName.calculation);
                              },

                              // goTo: RouteName.calculation
                          ),
                        ],
                      ),
                    ],
                  ),
                ).pad(left: 16, right: 16,top: 24, bottom: MediaQuery.of(context).padding.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
