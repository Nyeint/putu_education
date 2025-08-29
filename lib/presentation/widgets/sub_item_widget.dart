import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';

class SubItemWidget extends StatelessWidget {
  String title;
  String iconName;
  String goTo;
  SubItemWidget({super.key, required this.title, required this.iconName, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> context.pushNamed(goTo),
      child: SizedBox(
          width: context.width/2.4,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorResources.lightBg,
                  ),
                  child:
                  // SvgPicture.asset("assets/images/$iconName.svg", fit: BoxFit.cover,),
                  Image.asset(
                    'assets/images/$iconName.png', // Your image path
                    width: double.infinity,
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),
              Positioned(
                // alignment: Alignment.bottomCenter,
                  bottom: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset("assets/images/cone.svg", width: context.width/2.4,),
                      Text(title, style: FontFamily().bold,).pad(top: 10)
                    ],
                  )
                // SvgPicture.asset("assets/images/cone.svg", width: context.width/2.4,)
              )

            ],
          )
      ),
    );
  }
}
