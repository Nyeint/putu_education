import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SubItemWidget extends StatelessWidget {
  String title;
  String iconName;
  // String goTo;
  VoidCallback? onTap;
  SubItemWidget({super.key,
    required this.title,
    required this.iconName,
    // required this.goTo,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap!(),
      child: SizedBox(
          width: 170,
          // width: context.width/2.35,
          height: 200,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 170,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorResources.lightBg,
                    ),
                    child:
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child:
                      Image.asset(
                        'assets/images/$iconName.png', // Your image path
                        width: double.infinity,
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    )
                  // SvgPicture.asset("assets/images/$iconName.svg", fit: BoxFit.cover,),

                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 170,
                  height: 50,
                  // decoration: BoxDecoration(
                  //   color: Colors.deepPurple,
                  //   borderRadius: BorderRadius.circular(16),
                  // ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(16),
                    child: SvgPicture.asset(
                      "assets/images/cone.svg",
                      fit: BoxFit.fill, // Expands to the relative width
                      // colorFilter: ColorFilter.mode(
                      //   Colors.white.withOpacity(0.1),
                      //   BlendMode.srcIn,
                      // ),
                    ),
                  ),
                ),
              ),
              Align(
                // bottom: 10,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    style: FontFamily().bold.copyWith(fontSize: 17),)
                      .pad(bottom: 10))

            ],
          )
      ),
    );
  }
}
