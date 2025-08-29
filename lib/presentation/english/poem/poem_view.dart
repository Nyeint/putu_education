import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import 'package:putu_education/route/my_router.dart';
import '../../widgets/my_appbar.dart';

class EnglishPoemView extends StatefulWidget {
  const EnglishPoemView({super.key});

  @override
  State<EnglishPoemView> createState() => _EnglishPoemViewState();
}

class _EnglishPoemViewState extends State<EnglishPoemView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorResources.background,
            appBar: MyAppBar(
              titleWithGoBack: tr('poems'),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/light_background.png",),
                      fit: BoxFit.cover)
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      itemCount: 10,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: ()=>
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SimpleExampleApp())),
                                context.pushNamed(RouteName.poemDetail),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.only(bottom: 16),
                              height: context.width/3+32,
                              decoration: unselectedDecoration(),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.circular(20)),
                              //   color: ColorResources.lightBg
                              // ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      // height: context.height/3,
                                      width: context.width/3.5,
                                      // height: context.width/3,
                                      // height: 120,
                                      // width: 105,
                                      // height: 120,
                                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzQsZ_eIOQUbslPOr1t4BAHfPyx35K8ET7Ng&usqp=CAU',
                                      // placeholder: (context, url) => new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Center(child: new Icon(Icons.error)),
                                      placeholder: (context, url) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                          border: Border.all(color: ColorResources.lightBg),
                                        ),
                                        child:
                                        Icon(Icons.image,color: ColorResources.primary, size: context.width/3.5,),
                                      ),
                                      // height: height,
                                      // width: width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            // width: (context.width- context.width/3.5)-100,
                                            // height: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('A Little ', style: FontFamily().semiBold.copyWith(fontSize:
                                                FontSize().sixteen
                                                ),
                                                ),
                                                Flexible(
                                                  child: Text('By reading the A Little Turtle poem, your little one would understand the characteristics of a turtle in just a few lines.',
                                                    style: FontFamily().regular.copyWith(
                                                        color: ColorResources.subText, fontSize: FontSize().fourteen,
                                                    ),
                                                    // overflow: TextOverflow.ellipsis,
                                                    // maxLines: 2,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('02:00 mins', style: FontFamily().regular.copyWith(
                                                color: ColorResources.subText, fontSize: FontSize().fourteen
                                            // context.width/25.5,
                                            ),),
                                            // Image.asset('assets/images/empty_message.png', width: 20, height: 20,),
                                            GestureDetector(onTap: (){},
                                                child:  SvgPicture.asset("assets/icons/next.svg", height: 16,)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ).pad(left: 16, right: 16),
              ),
            )
        )
    );
  }
}
