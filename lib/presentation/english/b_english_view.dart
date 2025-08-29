// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
// import 'package:putu_education/app/config/config.dart';
// import 'package:putu_education/app/config/widget_extensions.dart';
//
// import '../../app/config/color_resources.dart';
//
// class EnglishView extends StatefulWidget {
//   const EnglishView({super.key});
//
//   @override
//   State<EnglishView> createState() => _EnglishViewState();
// }
//
// class _EnglishViewState extends State<EnglishView> {
//
//   itemWidget(String title){
//     return GestureDetector(
//       onTap: (){
//       },
//       child: Container(
//           width: context.width/2.2,
//           height: context.width/4.4,
//           // padding: EdgeInsets.only(left: 40, right: 40, top: 25, bottom: 25),
//           decoration: BoxDecoration(
//             borderRadius: new BorderRadius.all(Radius.elliptical(100, 60)),
//             color: ColorResources.white,
//           ),
//           child: Center(child: Text(title, style: FontFamily().bold.copyWith(color: ColorResources.itemPrimary)))),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: ColorResources.english.withOpacity(0.5),
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: ColorResources.english.withOpacity(0.5),
//             leading: GestureDetector(
//               onTap: (){
//                 context.pop();
//               },
//               child: Icon(Icons.arrow_back),
//             ),
//             title: Text(tr('learn_english'), style: FontFamily().bold.copyWith(color: ColorResources.itemPrimary))
//           ),
//           body: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Positioned(
//                 bottom: context.width/2.3,
//                 right: 0,
//                 child: Image.asset('assets/images/brick.png',width: context.width/2 ,height: context.width/2,),
//               ),
//               Positioned(
//                 bottom: context.width/4,
//                 left: 0,
//                 child: Image.asset('assets/images/music.png', width: context.width/2.5 ,height: context.width/2.5,),
//               ),
//               Positioned(
//                 // alignment: Alignment.bottomRight,
//                 bottom: 0,
//                 right: 10,
//                 child: Image.asset('assets/images/animals/rabbit.png', width: context.width/2 ,height: context.width/2,),
//               ),
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 30,),
//                     itemWidget('English'),
//                     SizedBox(height: 10,),
//                     itemWidget('Word'),
//                     SizedBox(height: 10,),
//                     itemWidget('Song'),
//                     SizedBox(height: 10,),
//                     itemWidget('Card Order'),
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         ));
//   }
// }
