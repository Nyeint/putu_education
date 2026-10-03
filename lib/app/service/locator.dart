// Path: service/locator.dart
import 'package:get_it/get_it.dart';
import '../../data/providers/score_provider.dart';
import '../../data/providers/settings_info_provider.dart';
import '../../data/providers/timer_info_provider.dart';
import '../../features/topics/data/repositories/alphabet_repo_impl.dart';
import '../../features/topics/data/repositories/game_repo_impl.dart';
import '../../features/topics/data/repositories/number_repo_impl.dart';
import '../../features/topics/data/repositories/poemtory_repo_impl.dart';
import '../../features/topics/data/repositories/vocab_repo_impl.dart';
import '../../features/topics/domain/repositories/alphabet_repo.dart';
import '../../features/topics/domain/repositories/game_repo.dart';
import '../../features/topics/domain/repositories/number_repo.dart';
import '../../features/topics/domain/repositories/poemtory_repo.dart';
import '../../features/topics/domain/repositories/vocab_repo.dart';
import '../../features/topics/presentation/bloc/alphabet_bloc/alphabet_bloc.dart';
import '../../features/topics/presentation/bloc/game_bloc/game_bloc.dart';
import '../../features/topics/presentation/bloc/number_bloc/number_bloc.dart';
import '../../features/topics/presentation/bloc/poemtory_bloc/poemtory_bloc.dart';
import '../../features/topics/presentation/bloc/vocab_bloc/vocab_bloc.dart';
import '../../features/settings/bloc/check_update_bloc.dart';
import '../../features/settings/data/check_update_repo_impl.dart';
import '../../features/settings/domain/check_update_repo.dart';
import '../../network/dio_basenetwork.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<SettingsInfoProvider>(() => SettingsInfoProvider());
  getIt.registerLazySingleton<TimerInfoProvider>(() => TimerInfoProvider());

  final scoreProvider = ScoreProvider();
  await scoreProvider.load();
  getIt.registerSingleton<ScoreProvider>(scoreProvider);

  // Shared network client
  getIt.registerLazySingleton<DioBaseNetwork>(() => DioBaseNetwork());

  // Topics/Vocabulary feature
  getIt.registerLazySingleton<VocabRepo>(() => VocabRepoImpl(getIt<DioBaseNetwork>()));
  // Fresh bloc per screen visit - its state isn't shared across screens.
  getIt.registerFactory<VocabBloc>(() => VocabBloc(getIt<VocabRepo>()));

  // Topics/Poemtory (poems/stories/songs) feature
  getIt.registerLazySingleton<PoemToryRepo>(() => PoemToryRepoImpl(getIt<DioBaseNetwork>()));
  // Fresh bloc per screen visit - its state isn't shared across screens.
  getIt.registerFactory<PoemToryBloc>(() => PoemToryBloc(getIt<PoemToryRepo>()));

  // Topics/Games (choose-picture, etc.) feature
  getIt.registerLazySingleton<GameRepo>(() => GameRepoImpl(getIt<DioBaseNetwork>()));
  // Fresh bloc per screen visit - its state isn't shared across screens.
  getIt.registerFactory<GameBloc>(() => GameBloc(getIt<GameRepo>()));

  // Topics/Numbers feature
  getIt.registerLazySingleton<NumberRepo>(() => NumberRepoImpl(getIt<DioBaseNetwork>()));
  // Fresh bloc per screen visit - its state isn't shared across screens.
  getIt.registerFactory<NumberBloc>(() => NumberBloc(getIt<NumberRepo>()));

  // Topics/Alphabets feature
  getIt.registerLazySingleton<AlphabetRepo>(() => AlphabetRepoImpl(getIt<DioBaseNetwork>()));
  // Fresh bloc per screen visit - its state isn't shared across screens.
  getIt.registerFactory<AlphabetBloc>(() => AlphabetBloc(getIt<AlphabetRepo>()));

  // Settings/Check for updates feature
  getIt.registerLazySingleton<CheckUpdateRepo>(() => CheckUpdateRepoImpl(getIt<DioBaseNetwork>()));
  getIt.registerFactory<CheckUpdateBloc>(() => CheckUpdateBloc(getIt<CheckUpdateRepo>()));
}
