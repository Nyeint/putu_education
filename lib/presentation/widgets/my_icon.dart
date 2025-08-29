import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import '../../app/config/color_resources.dart';

class MyIcon extends StatelessWidget {
  String? iconName;
  Color? color;
  double padding;
  IconData? icon;
  MyIcon({super.key, this.iconName, this.color, this.padding=4, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorResources.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            spreadRadius: 0.4,
            offset: Offset(0, 2.0), // bottom shadow
          ),
          // BoxShadow(
          //     color: Colors.black,
          //     // offset: Offset(0.0, 1.0), //(x,y)
          //     // blurRadius: 6.0,
          //     spreadRadius: 4.0,
          //   offset: Offset(0, 2.0),
          // ),
        ],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black26,
        //     blurRadius: 2.0,
        //     spreadRadius: 1.0,
        //     offset: Offset(2.0, 2.0), // shadow direction: bottom right
        //   )
        // ],
      ),

      padding: EdgeInsets.all(padding),
      child: icon==null?
      SvgPicture.asset("assets/icons/$iconName.svg",color: color, height: context.width*0.045):
          Icon(icon)
    );
  }
}
