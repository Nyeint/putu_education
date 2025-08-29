import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/route/my_router.dart';
import '../../main.dart';
import 'font_size.dart';
import 'global_context.dart';

class FontFamily{
  // BuildContext? context = MyApp().scaffoldKey.currentContext;
  BuildContext? context = GlobalContext.navigatorKey.currentContext;
  TextStyle get light{
    return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
        fontWeight: FontWeight.w300, fontSize: FontSize().sixteen);
  }

  TextStyle get regular{
    return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
        fontWeight: FontWeight.w400, fontSize: FontSize().sixteen);
  }

  TextStyle get medium{
    return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
        fontWeight: FontWeight.w500, fontSize: FontSize().sixteen);
  }

  TextStyle get semiBold{
    return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
        fontWeight: FontWeight.w600, fontSize: FontSize().eighteen);
  }

  TextStyle get bold{
    return TextStyle(fontFamily: context==null?'Nunito':context!.locale.languageCode == 'en'?'Nunito':'MyanmarEthnic',
        fontWeight: FontWeight.w700, fontSize: FontSize().eighteen);
  }
}