import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';

class ResultView extends StatefulWidget {
  int score;
  Widget childWidget;
  ResultView({super.key, required this.score, required this.childWidget});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primary,
      // appBar: MyAppBar(
      //   titleWithGoBack: '${tr('result')}',
      // ),
      body: SafeArea(
        bottom: false,
          child: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/result_bg.png",),
                    fit: BoxFit.cover)
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: 80,),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(20),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(top: 16),
                          margin: EdgeInsets.only(top: context.width*0.12), // Adjust this value to control how much of the ribbon is inside the box
                          // padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    Text('Your score:', style: FontFamily().medium.copyWith(fontSize: FontSize().eighteen),),
                                    Text(context.locale.languageCode == 'en'?widget.score.toString():widget.score.toString().burmese(), style: FontFamily().bold.copyWith(fontSize:FontSize().fortyEight),),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star, color: Colors.white, size: context.width*0.123),
                                        SizedBox(width: 7,),
                                        Icon(Icons.star, color: Colors.white, size: context.width*0.123),
                                        SizedBox(width: 7,),
                                        Icon(Icons.star, color: Colors.white, size: context.width*0.123),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          // top: 30,
                          top: context.width*0.06,
                          child: Container(
                            padding: EdgeInsets.only(left: context.width*0.1, right: context.width*0.1, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              // color: ColorResources.white,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/golden_ribbon.png"),
                                  fit: BoxFit.cover
                              ),
                              // borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Text('Congratulations', style: FontFamily().bold.copyWith(fontSize: FontSize().twenty),),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      context.pop();
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                        decoration: selectedTabDecoration(),
                        child: Text(tr('go_home'))
                    ),
                  ),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      widget.childWidget,
                      Align(
                        // top: 0,
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.center,
                            // height: 60,
                            padding: EdgeInsets.only(top: context.width*0.04, bottom: context.width*0.04),
                            // padding: EdgeInsets.only(top: 15, bottom: 15),
                            width: context.width-32,
                            // padding: EdgeInsets.only(top: 16, bottom: 16),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ColorResources.secondary,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                  offset: Offset(0, 2.0), // bottom shadow
                                ),
                              ],
                            ),
                            child: Text('Answers', style: FontFamily().semiBold.copyWith(fontSize: FontSize().twenty),),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),

                ],
              ),
            ),
          )),
    );
  }
}
