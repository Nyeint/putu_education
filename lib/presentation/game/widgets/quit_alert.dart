import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_icon.dart';

void quitAlert(BuildContext context) {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (context, StateSetter setState){
            return Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  // onTap: picClose,
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: MyIcon(iconName: 'pic_close', padding: 7))),
                            SizedBox(height: 8,),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/yellow_slider.png",),
                                    fit: BoxFit.cover),
                                border: Border.all(color: Colors.white, width: 6),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/icons/sad.png', width: context.width*0.2),
                                  Text(tr('sure_quit_game'), style: FontFamily().medium.copyWith(fontSize: FontSize().eighteen),),
                                  SizedBox(height: 8,),
                                  Container(
                                      padding: EdgeInsets.only(left: 30, right: 30,top: 8, bottom: 8),
                                      decoration: selectedTabDecoration(),
                                      child: Text(tr('yes'), style: FontFamily().medium.copyWith(fontSize: FontSize().eighteen),)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                            top: 20,
                            // left: context.width*0.15,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.only(left: context.width*0.1, right: context.width*0.1, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Text(tr('quit'), style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),),
                              ),
                            )
                        ),
                      ],
                    ),
                  )
              ),
            );
          });
    },
  );
}