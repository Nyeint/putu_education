import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../app/config/config.dart';
import '../../route/route_name.dart';
import '../widgets/my_appbar.dart';
import '../widgets/sub_item_widget.dart';

class MathView extends StatefulWidget {
  const MathView({super.key});

  @override
  State<MathView> createState() => _MathViewState();
}

class _MathViewState extends State<MathView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorResources.background,
            appBar: MyAppBar(
              titleWithGoBack: tr('math'),
            ),
          body: Container(
            height: context.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/water_background.png",),
                    fit: BoxFit.cover)
            ),
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
                          title: tr('shapes'), iconName: 'shape', goTo: RouteName.shape),
                      SubItemWidget(
                          title: tr('calculation'), iconName: 'calculation', goTo: RouteName.calculation),
                    ],
                  ),
                ],
              ),
            ).pad(left: 16, right: 16,top: 24),
          ),
        ));
  }
}
