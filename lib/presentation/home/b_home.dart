// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
// import 'package:putu_education/app/config/widget_extensions.dart';
// import 'package:putu_education/presentation/english/b_english_view.dart';
// import 'package:putu_education/route/my_router.dart';
// import '../../app/config/color_resources.dart';
// import '../../app/config/font_family.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//
//   sectionItem({required String image, required String title, required String subTitle, required Color color, required String goTo}){
//     return GestureDetector(
//       onTap: (){
//         context.pushNamed(goTo);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => const EnglishView()),
//         // );
//       },
//       child: Container(
//           padding: EdgeInsets.all(10),
//           width: context.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: color,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset(image, width: context.width/3.2, height: context.width/4,),
//               SizedBox(width: 10,),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title, style: FontFamily().bold.copyWith(color: Colors.white, fontSize: context.locale.languageCode == 'en'?20:18),),
//                     SizedBox(height: 10,),
//                     Text(subTitle, style: FontFamily().regular.copyWith(color: Colors.white, fontSize: context.locale.languageCode == 'en'?16:14),
//                       // TextStyle(color: Colors.white, fontSize: 16,)
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           )
//       ),
//     );
//   }
//
//   progressItem({required String title, required String mark}){
//     return  Card(
//       elevation: 2,
//       surfaceTintColor: ColorResources.white,
//       color: ColorResources.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         side: BorderSide(
//           color: ColorResources.itemSecondary.withOpacity(0.3)
//         )
//       ),
//       child: Column(
//         children: [
//           Text(title, style: FontFamily().bold.copyWith(fontSize: context.locale.languageCode == 'en'?17:15)),
//           Text(mark, style: FontFamily().bold.copyWith(color: ColorResources.markColor)),
//           ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(ColorResources.math)
//               ),
//               onPressed: (){
//
//               },
//               child: Text('Start Now', style: FontFamily().regular.copyWith(color: ColorResources.textSecondary),
//               ))
//         ],
//       ).pad(left: 10, right: 10, top: 10, bottom: 10),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color(0xffFAF5FC),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20,),
//           Text('PuTu', style: TextStyle(fontSize: 30),),
//           Text('Kids\' aid education', style: TextStyle(fontSize: 14),),
//           SizedBox(height: 30,),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Wrap(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: ColorResources.muteBackground,
//                           borderRadius: BorderRadius.circular(10),
//
//                         ),
//                         child: Text(tr('progress_indication'), style: FontFamily().semiBold.copyWith(fontSize: 16, color: ColorResources.mute),),
//                       ),
//                       SizedBox(width: 10,),
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             color: ColorResources.muteBackground,
//                             shape: BoxShape.circle
//                           // borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(Icons.arrow_forward),
//                       ),
//
//                     ],
//                   ),
//                   SizedBox(height: 10,),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         progressItem(
//                             title: tr('mathematics'),
//                             mark: '50'
//                         ),
//                         progressItem(
//                             title: tr('burmese'),
//                             mark: '70'
//                         ),
//                         progressItem(
//                             title: tr('burmese'),
//                             mark: '70'
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Card(
//                   //   elevation: 2,
//                   //   surfaceTintColor: ColorResources.white,
//                   //   color: ColorResources.white,
//                   //   child: Column(
//                   //     children: [
//                   //       Text(tr('mathematics'), style: FontFamily().bold),
//                   //       Text('50', style: FontFamily().bold.copyWith(color: ColorResources.markColor)),
//                   //       ElevatedButton(
//                   //         style: ButtonStyle(
//                   //           backgroundColor: MaterialStateProperty.all<Color>(ColorResources.math)
//                   //         ),
//                   //           onPressed: (){
//                   //
//                   //           },
//                   //           child: Text('Start Now', style: FontFamily().regular.copyWith(color: ColorResources.textSecondary),
//                   //           ))
//                   //     ],
//                   //   ).pad(left: 10, right: 10, top: 10, bottom: 10),
//                   // ),
//                   SizedBox(height: 30,),
//                   Align(
//                       alignment: Alignment.topLeft,
//                       child: Text('Room Section', style: TextStyle(fontSize: 25),)
//                   ),
//                   sectionItem(
//                     image: 'assets/images/animals/pig.png',
//                     title: tr('story_poem'),
//                     subTitle: tr('learn_sp'),
//                     color: ColorResources.story_poem,
//                     goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                     image: 'assets/images/animals/bird.png',
//                     title: tr('mathematics'),
//                     subTitle: tr('learn_math'),
//                     color: ColorResources.math,
//                       goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                     image: 'assets/images/animals/deer.png',
//                     title: tr('burmese'),
//                     subTitle: tr('learn_burmese'),
//                     color: ColorResources.burmese,
//                       goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                     image: 'assets/images/animals/turtle.png',
//                     title: tr('english'),
//                     subTitle: tr('learn_english'),
//                     color: ColorResources.english,
//                       goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                     image: 'assets/images/animals/octopus.png',
//                     title: tr('animal'),
//                     subTitle: tr('learn_animals'),
//                     color: ColorResources.animal,
//                       goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                     image: 'assets/images/animals/whale.png',
//                     title: tr('fruit_veg'),
//                     subTitle: tr('learn_fruits'),
//                     color: ColorResources.fruit_veg,
//                       goTo: RouteName.english
//                   ),
//                   SizedBox(height: 12,),
//                   sectionItem(
//                       image: 'assets/images/animals/bear.png',
//                       title: tr('color'),
//                       subTitle: tr('learn_colors'),
//                       color: ColorResources.color,
//                       goTo: RouteName.english
//                     // color: Color(0xffAF5027),
//                   ),
//                   SizedBox(height: 20,),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ).pad(left: 15, right: 15),
//     );
//   }
// }
