// Path: math/math_view.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/utils/en_types.dart';
import 'package:putu_education/features/topics/presentation/pages/math/shape/shape_view.dart';
import '../../../../../app/config/config.dart';
import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../../route/route_name.dart';
import '../../../../widgets/my_appbar.dart';
import '../../../../widgets/sub_item_widget.dart';
import 'calculation/calculation_view.dart';

class MathView extends StatefulWidget {
  String? learnLanguageType;
  MathView({super.key, this.learnLanguageType});

  @override
  State<MathView> createState() => _MathViewState();
}

class _MathViewState extends State<MathView> {
  @override
  Widget build(BuildContext context) {
    final itemWidth = ((context.width - 20 - 12) / 2).floorToDouble().clamp(0.0, 170.0);
    return Scaffold(
        backgroundColor: ColorResources.background,
      // bottomNavigationBar: const BannerAdWidget(),
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
                titleWithGoBack: widget.learnLanguageType=='en'?'Math':'သင်္ချာ',
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
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SubItemWidget(
                            width: itemWidth,
                            title: widget.learnLanguageType=='en'?'Shapes':'ပုံသဏ္ဍာန်များ',
                            iconName: 'shape',
                            onTap: (){
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
                              }
                            },
                          ),
                          SubItemWidget(
                            width: itemWidth,
                            title: widget.learnLanguageType=='en'?'Calculation':'အတွက်အချက်',
                            iconName: 'calculation',
                            onTap: (){
                              // context.pushNamed(RouteName.calculation);

                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CalculationView(
                                  learnLanguageType: widget.learnLanguageType ?? LearnLanguageType.mm.name,
                                );
                              }));
                            },
                            // goTo: RouteName.calculation
                          ),
                        ],
                      ),
                    ],
                  ),
                ).pad(left: 10, right: 10,top: 24, bottom: MediaQuery.of(context).padding.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
