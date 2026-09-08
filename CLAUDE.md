# Project Context

## Overview

- **Type:** monorepo
- **Tech Stack:** Dio, Provider, GoRouter
- **Entry Points:** lib/lib/main.dart

## Architecture

### Layers

- Widget (22 files)
- Model (8 files)
- Utility (3 files)
- Provider (3 files)
- Service (2 files)
- Data (2 files)
- Presentation (1 file)

### Layer Dependencies

- Provider → Model
- Service → Data
- Widget → Data, Service

## Directory Structure

```
lib/
  app/
    config/
      api_constants.dart
      color_resources.dart
      config.dart
      font_family.dart
      font_size.dart
      global_context.dart
      theme.dart
      widget_extensions.dart
    service/
      locator.dart
      tts_service.dart
    utils/
      ad_helper.dart
      device_checker.dart
      en_types.dart
    widgets/
      err_state_widget/
        connection_timeout_widget.dart
        maintain_widget.dart
        no_data_widget.dart
        no_internet_widget.dart
        not_found_widget.dart
        server_err_widget.dart
        too_many_request_widget.dart
        unknown_err_widget.dart
      empty_widget.dart
      err_widget.dart
      loading_widgets.dart
      more_widget.dart
      my_button.dart
      my_card.dart
    typedef_factory.dart
  data/
    external_refresh_builder/
      external_refresh_ui_bloc.dart
      external_refresh_ui_builder.dart
    model/
      game_category.dart
      music_ob_class.dart
      paginate_ob.dart
      pn_ob_class.dart
      response_ob.dart
    providers/
      score_provider.dart
      settings_info_provider.dart
      timer_info_provider.dart
    refresh_builder/
      refresh_ui_bloc.dart
      refresh_ui_builder.dart
    single_ui_builder/
      single_ui_bloc.dart
      single_ui_builder.dart
    model_factory.dart
    shared_prefs_helper.dart
  network/
    dio_basenetwork.dart
  presentation/
    dashboard/
      dashboard.dart
      language_selection.dart
      lessons_view.dart
      progress_indicator.dart
    english/
      alphabet/
        alphabet_view.dart
      number/
        number_view.dart
      poem/
        player_widget.dart
        poem_detail.dart
        poem_view.dart
      vocabulary/
        vocabulary_view.dart
      b_english_view.dart
      english_view.dart
    game/
      english/
        english.dart
        sentence_sort_game.dart
        sort_result.dart
        word_game.dart
        word_result.dart
        word_sort_game.dart
      math/
        calculate_game.dart
        counting_game.dart
        math.dart
      model/
        calculate_history.dart
        question_result.dart
        word_item.dart
      myanmar/
        myanmar.dart
      widgets/
        back_flip_card.dart
        front_flip_card_item.dart
        progress_bar.dart
        quit_alert.dart
        result_view.dart
        title_item.dart
        voice_item.dart
    home/
      b_home.dart
    introduction/
      introduction.dart
    math/
      calculation/
        addition_view.dart
        calculation_view.dart
        division_view.dart
        multiplication_view.dart
        substraction_view.dart
      shape/
        shape_painter.dart
        shape_view.dart
      math_view.dart
    myanmar/
      alphabet/
        alphabet_view.dart
      number/
        number_view.dart
      myanmar_view.dart
    onboarding/
      screen_one.dart
    search/
      search_item.dart
      search_view.dart
    settings/
      b_settings.dart
    test/
      phone_number.dart
    widgets/
      go_button.dart
      item_decoration.dart
      item_voice_dialog.dart
      item_voice_widget.dart
      my_appbar.dart
      my_icon.dart
      overlay_photo.dart
      sub_item_widget.dart
    b_dashboard.dart
  route/
    my_router.dart
    route.dart
    route_name.dart
    route_path.dart
  main.dart
```

## Conventions

- File naming: snake_case with suffixes (_service, _helper, _widget, _bloc, _provider, _view)
- Class naming: PascalCase with suffixes (Service, Helper, Widget, Bloc, State, Model, Provider, View, Page)
- File purposes: widget (76), other (19), model (8), bloc (3), provider (3), service (2), helper (2), utility (2), view (1), test (1)

## Dependencies

- flutter: 88 files
- putu_education: 52 files
- easy_localization: 39 files
- go_router: 20 files
- flutter_svg: 18 files
- provider: 12 files
- flutter_tts: 8 files
- cached_network_image: 8 files
- lottie: 7 files
- rxdart: 3 files
- get_it: 2 files
- pull_to_refresh: 2 files
- audioplayers: 2 files
- device_info_plus: 1 file
- path_provider: 1 file

## Code Health

- 117 files, 12509 lines of Dart code
- 139 classes, 311 methods
- Average 106.8 LOC/file, 0.5% comment ratio
- 109 files without comments

### Technical Debt

- 18 TODO comments
- Largest files: search_view.dart (575), refresh_ui_builder.dart (433), player_widget.dart (386), external_refresh_ui_builder.dart (336), single_ui_builder.dart (309)

