import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/route/my_router.dart';
import '../../main.dart';
import 'global_context.dart';

class FontSize{
  // BuildContext? context = MyApp().scaffoldKey.currentContext;
  // BuildContext? context = globalContext;
  BuildContext? context = GlobalContext.navigatorKey.currentContext;

  double get fortyEight{
    return context==null?64:context!.locale.languageCode == 'en'?context!.width*0.13:context!.width*0.13-2; // Example for title font size
  }

  double get thirtyTwo{
    return context==null?64:context!.locale.languageCode == 'en'?context!.width*0.09:context!.width*0.09-2; // Example for title font size
  }
  double get sixteenFour{
    return context==null?64:context!.locale.languageCode == 'en'?context!.width/5.5:context!.width/5.5-2; // Example for title font size
  }

  double get twentyFour{
    return context==null?24:context!.locale.languageCode == 'en'?context!.width/15:context!.width/15-2; // Example for title font size
  }

  double get twenty{
    return context==null?20:context!.locale.languageCode == 'en'?context!.width/18:context!.width/18-2; // Example for title font size
  }

  double get eighteen{
    return context==null?18:context!.locale.languageCode == 'en'?context!.width/20:context!.width/20-2; // Example for title font size
  }

  double get sixteen{
    return context==null?16:context!.locale.languageCode == 'en'?context!.width/22.5:context!.width/22.5-2; // Example for title font size
  }

  double get fourteen{
    return context==null?16:context!.locale.languageCode == 'en'?context!.width/25.5:context!.width/25.5-2; // Example for title font size
  }
  // double get eighteen {
  //   return context.size!.height*0.018;
  // }

  // TextStyle get light{
  //   return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
  //       fontWeight: FontWeight.w300, fontSize: context==null?16:context!.locale.languageCode == 'en'?16:14);
  // }
  //
  // TextStyle get regular{
  //   return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
  //       fontWeight: FontWeight.w400, fontSize: context==null?16:context!.locale.languageCode == 'en'?16:14);
  // }
  //
  // TextStyle get medium{
  //   return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
  //       fontWeight: FontWeight.w500, fontSize: context==null?16:context!.locale.languageCode == 'en'?16:14);
  // }
  //
  // TextStyle get semiBold{
  //   return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
  //       fontWeight: FontWeight.w600, fontSize: context==null?16:context!.locale.languageCode == 'en'?18:16);
  // }
  //
  // TextStyle get bold{
  //   return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
  //       fontWeight: FontWeight.w700, fontSize: context==null?16:context!.locale.languageCode == 'en'?18:16);
  // }
}