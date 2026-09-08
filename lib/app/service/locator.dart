// Path: service/locator.dart
import 'package:get_it/get_it.dart';
import '../../data/providers/score_provider.dart';
import '../../data/providers/settings_info_provider.dart';
import '../../data/providers/timer_info_provider.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<SettingsInfoProvider>(() => SettingsInfoProvider());
  getIt.registerLazySingleton<TimerInfoProvider>(() => TimerInfoProvider());

  final scoreProvider = ScoreProvider();
  await scoreProvider.load();
  getIt.registerSingleton<ScoreProvider>(scoreProvider);
}
