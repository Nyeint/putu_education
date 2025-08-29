// import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:putu_education/app/config/font_family.dart';
// import 'package:putu_education/app/config/widget_extensions.dart';
// import 'package:putu_education/presentation/settings/b_settings.dart';
// import '../app/config/color_resources.dart';
// import 'home/b_home.dart';
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeView(),
//     HomeView(),
//     SettingsView(),
//   ];
//
//   // sectionItem({required String image, required String title, required String subTitle, required Color color}){
//   //   return Container(
//   //       padding: EdgeInsets.all(10),
//   //       width: context.width,
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(15),
//   //         color: color,
//   //       ),
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //         children: [
//   //           Image.asset(image, width: context.width/3.2, height: context.width/4,),
//   //           SizedBox(width: 10,),
//   //           Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text(title, style: FontFamily().bold.copyWith(color: Colors.white, fontSize: context.locale.languageCode == 'en'?20:18),),
//   //                 SizedBox(height: 10,),
//   //                 Text(subTitle, style: FontFamily().regular.copyWith(color: Colors.white,fontSize: 16,),
//   //                   // TextStyle(color: Colors.white, fontSize: 16,)
//   //                 ),
//   //               ],
//   //             ),
//   //           )
//   //         ],
//   //       )
//   //   );
//   // }
//
//   List<TabItem> items = [
//     TabItem(
//       icon: Icons.home,
//     ),
//     TabItem(
//       icon: Icons.bar_chart,
//     ),
//     TabItem(
//       icon: Icons.settings,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           body: Column(
//             children: [
//               Expanded(
//                 child: _widgetOptions.elementAt(_selectedIndex),
//               ),
//               BottomBarInspiredInside(
//                 items: items,
//                 color: ColorResources.primary,
//                 colorSelected: ColorResources.white,
//                 indexSelected: _selectedIndex,
//                 backgroundColor: ColorResources.white,
//                 // backgroundColor:
//                 // themeData == 1? ColorResources.dark:
//                 // ColorResources.background,
//
//                 // color:  themeData == 1?ColorResources.background:ColorResources.dark,
//                 // colorSelected: themeData == 1?ColorResources.dark:ColorResources.primary,
//                 // indexSelected: ref.watch(tabIndex.notifier).state!,
//                 onTap: (int index) => setState(() {
//                   setState(() {
//                     _selectedIndex = index;
//                   });
//
//                   // visit = index;
//                   // switch (index){
//                   //   case 1:  ref.read(tabIndex.notifier).state = 1;
//                   //   context.goNamed(RouteNames.addBlog); break;
//                   //   case 2: ref.read(tabIndex.notifier).state = 2;
//                   //   context.goNamed(RouteNames.account);break;
//                   //   default: ref.read(tabIndex.notifier).state = 0;
//                   //   context.goNamed(RouteNames.viewBlog); break;
//                   // }
//                 }),
//                 chipStyle: ChipStyle(convexBridge: true, background:ColorResources.primary),
//                 // chipStyle: ChipStyle(convexBridge: true, background:themeData == 1?ColorResources.background:ColorResources.dark),
//                 itemStyle: ItemStyle.circle,
//                 animated: false,
//               ),
//             ],
//           )
//           // bottomNavigationBar: Container(
//           //   decoration: BoxDecoration(
//           //     color: ColorResources.white,
//           //     borderRadius: const BorderRadius.only(
//           //         topRight: Radius.circular(30), topLeft: Radius.circular(30)),
//           //   ),
//           //   child: ClipRRect(
//           //     borderRadius: const BorderRadius.only(
//           //       topLeft: Radius.circular(30.0),
//           //       topRight: Radius.circular(30.0),
//           //     ),
//           //     child: BottomNavigationBar(
//           //       // backgroundColor: ColorResources.cardDark,
//           //       type: BottomNavigationBarType.fixed,
//           //       items: <BottomNavigationBarItem>[
//           //         BottomNavigationBarItem(
//           //           icon: Image.asset('assets/icons/home.png',
//           //             width: MediaQuery.of(context).size.width * 0.07, // Adjust as needed
//           //             height: MediaQuery.of(context).size.width * 0.07,
//           //             color: _selectedIndex == 0 ? ColorResources.primary : ColorResources.itemSecondary,
//           //           ),
//           //           label: 'Home',
//           //         ),
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.bar_chart),
//           //           label: 'Library',
//           //         ),
//           //         BottomNavigationBarItem(
//           //           icon: Icon(Icons.settings),
//           //           label: 'Setting',
//           //         ),
//           //       ],
//           //       currentIndex: _selectedIndex,
//           //       selectedItemColor: ColorResources.primary,
//           //       unselectedItemColor: ColorResources.itemSecondary,
//           //       showUnselectedLabels: true,
//           //       selectedIconTheme: const IconThemeData(
//           //           color: ColorResources.primary
//           //       ),
//           //       onTap: _onItemTapped,
//           //     ),
//           //   ),
//           // ),
//         )
//     );
//   }
// }
