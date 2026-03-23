import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/my_icon.dart';

class ShapeView extends StatefulWidget {
  const ShapeView({super.key});

  @override
  State<ShapeView> createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  itemWidget({
    required String name,
    required String body,
    required String icon
  }){
    return  Container(
        width: context.width,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: unselectedDecoration(),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SvgPicture.asset("assets/icons/shapes/$icon.svg",
                    color: ColorResources.primary, height: context.width/4.5,),
                  SizedBox(height: 8,),
                  Text(name.capitalize(), style: FontFamily().semiBold.copyWith(fontSize: FontSize().twentyFour),),
                  Text(body, style: FontFamily().regular.copyWith(fontSize: FontSize().eighteen),)
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: MyIcon(iconName: 'volume',),)
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: tr('shape'),
      ),
      body: SafeArea(
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/light_background.png",),
                  fit: BoxFit.cover)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                itemWidget(name: tr('triangle'), body: tr('triangle_des'), icon: 'triangle'),
                itemWidget(name: tr('square'), body: tr('square_des'), icon: 'square'),
                itemWidget(name: tr('pentagon'), body: tr('pentagon_des'), icon: 'pentagon'),
                itemWidget(name: tr('hexagon'), body: tr('hexagon_des'), icon: 'hexagon'),
                itemWidget(name: tr('heptagon'), body: tr('heptagon_des'), icon: 'heptagon'),
                itemWidget(name: tr('octagon'), body: tr('octagon_des'), icon: 'octagon'),
                itemWidget(name: tr('nonagon'), body: tr('nonagon_des'), icon: 'nonagon'),
                itemWidget(name: tr('decagon'), body:  tr('decagon_des'), icon: 'decagon'),
                itemWidget(name: tr('circle'), body: tr('circle_des'), icon: 'circle'),
                itemWidget(name: tr('semicircle'), body: tr('semicircle_des'), icon: 'semicircle'),
                itemWidget(name: tr('oval'), body: tr('oval_des'), icon: 'oval'),
                itemWidget(name: tr('line'), body: tr('line_des'), icon: 'line'),
                itemWidget(name: tr('parallelogram'), body: tr('parallelogram_des'), icon: 'parallelogram')
              ],
            ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
          ),
        ),
      ),
    );
  }
}
