import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/presentation/widgets/my_icon.dart';
import '../../app/config/config.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  Widget? widget;
  String? titleWithGoBack;
  MyAppBar({Key? key, this.widget, this.titleWithGoBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            // color: ColorResources.primary,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[ColorResources.primary,ColorResources.primaryGradient]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  // offset: Offset(0.0, 1.0), //(x,y)
                  // blurRadius: 6.0,
                  // spreadRadius: 4.0,
                spreadRadius: 1,
                offset: Offset(0, 2.0),
              ),
            ],
          ),
          child:
          titleWithGoBack!=null?
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: ()=>context.pop(),
                      child: MyIcon(iconName: 'back'))
              ),
              Center(child:
              Text(titleWithGoBack!,
                style: FontFamily().medium.copyWith(fontSize: context.locale.languageCode == 'en'?24:22), maxLines: 1,))
            ],
          ).pad(left: 16, right: 16, top: 3, bottom: 3)
              :
          widget?.pad(left: 16, right: 16, top: 3, bottom: 3),
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
