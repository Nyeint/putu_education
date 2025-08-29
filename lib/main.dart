import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:putu_education/app/config/global_context.dart';
import 'package:putu_education/presentation/test/phone_number.dart';
import 'package:putu_education/route/route.dart';
import 'app/config/color_resources.dart';
import 'package:provider/provider.dart';

import 'app/config/theme.dart';
import 'app/service/tts_service.dart';
import 'data/providers/settings_info_provider.dart';
import 'data/providers/timer_info_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // MobileAds.instance.initialize();
  configLoading();
  TtsService.instance;
  // runApp(MyApp());
  runApp(
      EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('my', 'MM'),
          ],
          path: "languages",
          fallbackLocale: const Locale('en', 'US'),
          saveLocale: true,
          // child: MyApp()
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SettingsInfoProvider()),
              ChangeNotifierProvider(create: (_) => TimerInfoProvider()),
            ],
            child:

            MyApp()
        ),
      ));
}

class MyApp extends StatelessWidget {
 //  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
 // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorResources.primary,
      statusBarBrightness: Brightness.dark,
    ));
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Flutter Demo',
        theme: light,
        // theme: Provider.of<SettingsInfoProvider>(context, listen: true).themeType == ThemeType.light ? light:dark,
        // darkTheme: li,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      builder: (context, child) {
        // Integrate EasyLoading within the builder
        return Navigator(
          key: GlobalContext.navigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => EasyLoading.init()(context, child),
          ),
        );
      },
        // builder: EasyLoading.init(),
    );
    //   MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorResources.primary
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorResources.primary
    ..textColor = ColorResources.primary
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
  // ..boxShadow = <BoxShadow>[]
      ;
  // ..customAnimation = CustomAnimation();
}
