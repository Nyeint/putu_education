# Project Structure

- 📁 **app**
  - 📁 **config**
    - 📄 `app/config/api_constants.dart`
    - 📄 `app/config/color_resources.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
        </details>

    - 📄 `app/config/config.dart`
    - 📄 `app/config/font_family.dart`
        <details>
          <summary>Imports</summary>

          - `font_size.dart`
          - `global_context.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `app/config/font_size.dart`
        <details>
          <summary>Imports</summary>

          - `../../main.dart`
          - `global_context.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:putu_education/app/config/config.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

    - 📄 `app/config/global_context.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
        </details>

    - 📄 `app/config/theme.dart`
        <details>
          <summary>Imports</summary>

          - `color_resources.dart`
          - `font_family.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `app/config/widget_extensions.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/cupertino.dart`
        </details>

  - 📁 **service**
    - 📄 `app/service/locator.dart`
        <details>
          <summary>Imports</summary>

          - `../../data/providers/score_provider.dart`
          - `../../data/providers/settings_info_provider.dart`
          - `../../data/providers/timer_info_provider.dart`
          - `package:get_it/get_it.dart`
        </details>

    - 📄 `app/service/tts_service.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter_tts/flutter_tts.dart`
        </details>

  - 📄 `app/typedef_factory.dart`
      <details>
        <summary>Imports</summary>

        - `../data/model/response_ob.dart`
        - `../data/single_ui_builder/single_ui_builder.dart`
        - `package:flutter/material.dart`
      </details>

  - 📁 **utils**
    - 📄 `app/utils/ad_helper.dart`
        <details>
          <summary>Imports</summary>

          - `dart:io`
        </details>

    - 📄 `app/utils/device_checker.dart`
        <details>
          <summary>Imports</summary>

          - `dart:math`
          - `package:device_info_plus/device_info_plus.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `app/utils/en_types.dart`
  - 📁 **widgets**
    - 📄 `app/widgets/empty_widget.dart`
    - 📁 **err_state_widget**
      - 📄 `app/widgets/err_state_widget/connection_timeout_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/maintain_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/no_data_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/no_internet_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
            - `package:lottie/lottie.dart`
            - `package:putu_education/app/config/widget_extensions.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/not_found_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/server_err_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/too_many_request_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

      - 📄 `app/widgets/err_state_widget/unknown_err_widget.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

    - 📄 `app/widgets/err_widget.dart`
        <details>
          <summary>Imports</summary>

          - `../../data/model/response_ob.dart`
          - `err_state_widget/connection_timeout_widget.dart`
          - `err_state_widget/maintain_widget.dart`
          - `err_state_widget/no_internet_widget.dart`
          - `err_state_widget/not_found_widget.dart`
          - `err_state_widget/server_err_widget.dart`
          - `err_state_widget/too_many_request_widget.dart`
          - `err_state_widget/unknown_err_widget.dart`
          - `my_card.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `app/widgets/loading_widgets.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
          - `package:lottie/lottie.dart`
        </details>

    - 📄 `app/widgets/more_widget.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
        </details>

    - 📄 `app/widgets/my_button.dart`
        <details>
          <summary>Imports</summary>

          - `../config/color_resources.dart`
          - `../config/font_family.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `app/widgets/my_card.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
        </details>

- 📁 **data**
  - 📁 **external_refresh_builder**
    - 📄 `data/external_refresh_builder/external_refresh_ui_bloc.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/api_constants.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/response_ob.dart`
          - `../model_factory.dart`
          - `package:rxdart/rxdart.dart`
        </details>

    - 📄 `data/external_refresh_builder/external_refresh_ui_builder.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/typedef_factory.dart`
          - `../../app/widgets/err_state_widget/connection_timeout_widget.dart`
          - `../../app/widgets/err_state_widget/no_data_widget.dart`
          - `../../app/widgets/err_state_widget/no_internet_widget.dart`
          - `../../app/widgets/err_state_widget/not_found_widget.dart`
          - `../../app/widgets/err_state_widget/server_err_widget.dart`
          - `../../app/widgets/err_state_widget/too_many_request_widget.dart`
          - `../../app/widgets/err_state_widget/unknown_err_widget.dart`
          - `../../app/widgets/loading_widgets.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/response_ob.dart`
          - `external_refresh_ui_bloc.dart`
          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:pull_to_refresh/pull_to_refresh.dart`
        </details>

  - 📁 **model**
    - 📄 `data/model/game_category.dart`
    - 📄 `data/model/music_ob_class.dart`
    - 📄 `data/model/paginate_ob.dart`
    - 📄 `data/model/pn_ob_class.dart`
        <details>
          <summary>Imports</summary>

          - `../model_factory.dart`
        </details>

    - 📄 `data/model/response_ob.dart`
        <details>
          <summary>Imports</summary>

          - `package:putu_education/data/model/pn_ob_class.dart`
        </details>

  - 📄 `data/model_factory.dart`
  - 📁 **providers**
    - 📄 `data/providers/score_provider.dart`
        <details>
          <summary>Imports</summary>

          - `../model/game_category.dart`
          - `dart:convert`
          - `dart:io`
          - `package:flutter/foundation.dart`
          - `package:path_provider/path_provider.dart`
          - `package:shared_preferences/shared_preferences.dart`
        </details>

    - 📄 `data/providers/settings_info_provider.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/cupertino.dart`
        </details>

    - 📄 `data/providers/timer_info_provider.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/cupertino.dart`
        </details>

  - 📁 **refresh_builder**
    - 📄 `data/refresh_builder/refresh_ui_bloc.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/api_constants.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/pn_ob_class.dart`
          - `../model/response_ob.dart`
          - `package:rxdart/rxdart.dart`
        </details>

    - 📄 `data/refresh_builder/refresh_ui_builder.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/typedef_factory.dart`
          - `../../app/widgets/err_state_widget/unknown_err_widget.dart`
          - `../../app/widgets/err_widget.dart`
          - `../../app/widgets/loading_widgets.dart`
          - `../../app/widgets/more_widget.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/response_ob.dart`
          - `../single_ui_builder/single_ui_builder.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:pull_to_refresh/pull_to_refresh.dart`
          - `package:putu_education/app/config/widget_extensions.dart`
          - `refresh_ui_bloc.dart`
        </details>

  - 📄 `data/shared_prefs_helper.dart`
  - 📁 **single_ui_builder**
    - 📄 `data/single_ui_builder/single_ui_bloc.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/api_constants.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/response_ob.dart`
          - `../model_factory.dart`
          - `package:rxdart/rxdart.dart`
        </details>

    - 📄 `data/single_ui_builder/single_ui_builder.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/typedef_factory.dart`
          - `../../app/widgets/err_state_widget/connection_timeout_widget.dart`
          - `../../app/widgets/err_state_widget/maintain_widget.dart`
          - `../../app/widgets/err_state_widget/no_data_widget.dart`
          - `../../app/widgets/err_state_widget/no_internet_widget.dart`
          - `../../app/widgets/err_state_widget/not_found_widget.dart`
          - `../../app/widgets/err_state_widget/server_err_widget.dart`
          - `../../app/widgets/err_state_widget/too_many_request_widget.dart`
          - `../../app/widgets/err_state_widget/unknown_err_widget.dart`
          - `../../app/widgets/loading_widgets.dart`
          - `../../network/dio_basenetwork.dart`
          - `../model/response_ob.dart`
          - `package:flutter/material.dart`
          - `single_ui_bloc.dart`
        </details>

- 📄 `main.dart`
    <details>
      <summary>Imports</summary>

      - `app/config/color_resources.dart`
      - `app/config/theme.dart`
      - `app/service/locator.dart`
      - `app/service/tts_service.dart`
      - `data/providers/score_provider.dart`
      - `data/providers/settings_info_provider.dart`
      - `data/providers/timer_info_provider.dart`
      - `package:easy_localization/easy_localization.dart`
      - `package:flutter/material.dart`
      - `package:flutter/services.dart`
      - `package:flutter_easyloading/flutter_easyloading.dart`
      - `package:provider/provider.dart`
      - `package:putu_education/app/config/global_context.dart`
      - `package:putu_education/presentation/test/phone_number.dart`
      - `package:putu_education/route/route.dart`
    </details>

- 📁 **network**
  - 📄 `network/dio_basenetwork.dart`
      <details>
        <summary>Imports</summary>

        - `../data/model/response_ob.dart`
        - `dart:io`
        - `package:dio/dio.dart`
      </details>

- 📁 **presentation**
  - 📄 `presentation/b_dashboard.dart`
  - 📁 **dashboard**
    - 📄 `presentation/dashboard/dashboard.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/font_family.dart`
          - `../../app/service/locator.dart`
          - `../../data/providers/score_provider.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart`
          - `package:get_it/get_it.dart`
          - `package:go_router/go_router.dart`
          - `package:lottie/lottie.dart`
          - `package:putu_education/app/config/color_resources.dart`
          - `package:putu_education/app/config/widget_extensions.dart`
          - `package:putu_education/presentation/dashboard/lessons_view.dart`
          - `package:putu_education/presentation/dashboard/progress_indicator.dart`
          - `package:putu_education/presentation/test/phone_number.dart`
          - `package:putu_education/presentation/widgets/my_appbar.dart`
          - `package:putu_education/presentation/widgets/my_icon.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

    - 📄 `presentation/dashboard/language_selection.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/font_family.dart`
          - `../../data/providers/settings_info_provider.dart`
          - `../widgets/my_appbar.dart`
          - `../widgets/my_icon.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:flutter/widgets.dart`
          - `package:go_router/go_router.dart`
          - `package:provider/provider.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

    - 📄 `presentation/dashboard/lessons_view.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:go_router/go_router.dart`
          - `package:lottie/lottie.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

    - 📄 `presentation/dashboard/progress_indicator.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `../../data/providers/score_provider.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:go_router/go_router.dart`
          - `package:provider/provider.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

  - 📁 **english**
    - 📁 **alphabet**
      - 📄 `presentation/english/alphabet/alphabet_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../../widgets/my_icon.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/cupertino.dart`
            - `package:flutter/material.dart`
            - `package:flutter/widgets.dart`
            - `package:flutter_tts/flutter_tts.dart`
            - `package:provider/single_child_widget.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

    - 📄 `presentation/english/b_english_view.dart`
    - 📄 `presentation/english/english_view.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/font_family.dart`
          - `../../app/utils/en_types.dart`
          - `../math/math_view.dart`
          - `../widgets/my_appbar.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:go_router/go_router.dart`
          - `package:lottie/lottie.dart`
          - `package:putu_education/app/config/color_resources.dart`
          - `package:putu_education/app/config/widget_extensions.dart`
          - `package:putu_education/presentation/widgets/sub_item_widget.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

    - 📁 **number**
      - 📄 `presentation/english/number/number_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/service/tts_service.dart`
            - `../../widgets/my_icon.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_tts/flutter_tts.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/widgets/go_button.dart`
            - `package:putu_education/presentation/widgets/item_decoration.dart`
            - `package:putu_education/presentation/widgets/my_appbar.dart`
          </details>

    - 📁 **poem**
      - 📄 `presentation/english/poem/player_widget.dart`
          <details>
            <summary>Imports</summary>

            - `dart:async`
            - `package:audioplayers/audioplayers.dart`
            - `package:cached_network_image/cached_network_image.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/english/poem/poem_detail.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/my_appbar.dart`
            - `package:audioplayers/audioplayers.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/english/poem/player_widget.dart`
          </details>

      - 📄 `presentation/english/poem/poem_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/my_appbar.dart`
            - `package:cached_network_image/cached_network_image.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:go_router/go_router.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/widgets/item_decoration.dart`
            - `package:putu_education/route/my_router.dart`
          </details>

    - 📁 **vocabulary**
      - 📄 `presentation/english/vocabulary/vocabulary_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/service/tts_service.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_tts/flutter_tts.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/widgets/item_voice_dialog.dart`
            - `package:putu_education/presentation/widgets/item_voice_widget.dart`
          </details>

  - 📁 **game**
    - 📁 **english**
      - 📄 `presentation/game/english/english.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/my_appbar.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
            - `package:putu_education/presentation/game/widgets/title_item.dart`
            - `package:putu_education/route/my_router.dart`
          </details>

      - 📄 `presentation/game/english/sentence_sort_game.dart`
          <details>
            <summary>Imports</summary>

            - `../../../route/route_name.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../model/question_result.dart`
            - `../widgets/front_flip_card_item.dart`
            - `../widgets/progress_bar.dart`
            - `../widgets/voice_item.dart`
            - `dart:math`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:go_router/go_router.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
            - `package:putu_education/presentation/game/english/sort_result.dart`
          </details>

      - 📄 `presentation/game/english/sort_result.dart`
          <details>
            <summary>Imports</summary>

            - `../model/question_result.dart`
            - `../widgets/front_flip_card_item.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/english/word_game.dart`
          <details>
            <summary>Imports</summary>

            - `../../../route/route_name.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/item_voice_dialog.dart`
            - `../../widgets/my_appbar.dart`
            - `../model/question_result.dart`
            - `../model/word_item.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:flutter_tts/flutter_tts.dart`
            - `package:go_router/go_router.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
            - `package:putu_education/presentation/game/english/word_result.dart`
            - `package:putu_education/presentation/game/widgets/front_flip_card_item.dart`
            - `package:putu_education/presentation/game/widgets/progress_bar.dart`
            - `package:putu_education/presentation/game/widgets/voice_item.dart`
          </details>

      - 📄 `presentation/game/english/word_result.dart`
          <details>
            <summary>Imports</summary>

            - `../model/question_result.dart`
            - `package:cached_network_image/cached_network_image.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/english/word_sort_game.dart`
          <details>
            <summary>Imports</summary>

            - `../../../route/route_name.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../model/question_result.dart`
            - `../widgets/front_flip_card_item.dart`
            - `../widgets/progress_bar.dart`
            - `../widgets/voice_item.dart`
            - `dart:math`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:go_router/go_router.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
            - `package:putu_education/presentation/game/english/sort_result.dart`
          </details>

    - 📁 **math**
      - 📁 **calculate**
        - 📄 `presentation/game/math/calculate/calculation_result.dart`
            <details>
              <summary>Imports</summary>

              - `../../model/calculate_history.dart`
              - `../calculate_game.dart`
              - `digit_plus_minus.dart`
              - `icon_mul_div.dart`
              - `icon_plus_minus.dart`
              - `package:easy_localization/easy_localization.dart`
              - `package:flutter/material.dart`
              - `package:putu_education/app/config/config.dart`
            </details>

        - 📄 `presentation/game/math/calculate/digit_plus_minus.dart`
            <details>
              <summary>Imports</summary>

              - `../calculate_game.dart`
              - `package:flutter/material.dart`
              - `package:putu_education/presentation/game/math/calculate/text_widget.dart`
              - `package:putu_education/presentation/game/math/calculate/what_is.dart`
            </details>

        - 📄 `presentation/game/math/calculate/icon_mul_div.dart`
            <details>
              <summary>Imports</summary>

              - `package:flutter/material.dart`
              - `package:flutter_svg/svg.dart`
              - `package:putu_education/app/config/config.dart`
              - `package:putu_education/presentation/game/math/calculate/text_widget.dart`
              - `package:putu_education/presentation/game/math/calculate/what_is.dart`
              - `package:putu_education/presentation/game/math/calculate_game.dart`
            </details>

        - 📄 `presentation/game/math/calculate/icon_plus_minus.dart`
            <details>
              <summary>Imports</summary>

              - `package:flutter/material.dart`
              - `package:flutter_svg/svg.dart`
              - `package:putu_education/app/config/config.dart`
              - `package:putu_education/presentation/game/math/calculate/text_widget.dart`
              - `package:putu_education/presentation/game/math/calculate/what_is.dart`
            </details>

        - 📄 `presentation/game/math/calculate/text_widget.dart`
            <details>
              <summary>Imports</summary>

              - `package:easy_localization/easy_localization.dart`
              - `package:flutter/material.dart`
              - `package:putu_education/app/config/config.dart`
            </details>

        - 📄 `presentation/game/math/calculate/what_is.dart`
            <details>
              <summary>Imports</summary>

              - `../../../../app/config/config.dart`
              - `../../../widgets/item_decoration.dart`
              - `package:flutter/cupertino.dart`
            </details>

      - 📄 `presentation/game/math/calculate_game.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../model/calculate_history.dart`
            - `../widgets/progress_bar.dart`
            - `../widgets/voice_item.dart`
            - `calculate/calculation_result.dart`
            - `dart:math`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:go_router/go_router.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
            - `package:putu_education/presentation/game/math/calculate/digit_plus_minus.dart`
            - `package:putu_education/presentation/game/math/calculate/icon_mul_div.dart`
            - `package:putu_education/presentation/game/math/calculate/icon_plus_minus.dart`
            - `package:putu_education/route/my_router.dart`
          </details>

      - 📁 **counting**
        - 📄 `presentation/game/math/counting/counting_result.dart`
            <details>
              <summary>Imports</summary>

              - `../../model/question_result.dart`
              - `package:easy_localization/easy_localization.dart`
              - `package:flutter/material.dart`
              - `package:putu_education/app/config/config.dart`
            </details>

      - 📄 `presentation/game/math/counting_game.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../../data/model/game_category.dart`
            - `../../../data/providers/score_provider.dart`
            - `../../../route/route_name.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../model/question_result.dart`
            - `../widgets/progress_bar.dart`
            - `../widgets/voice_item.dart`
            - `dart:math`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:go_router/go_router.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/presentation/game/math/counting/counting_result.dart`
          </details>

      - 📄 `presentation/game/math/math.dart`
          <details>
            <summary>Imports</summary>

            - `../../../route/route_name.dart`
            - `../../widgets/my_appbar.dart`
            - `../widgets/title_item.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:provider/provider.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/data/model/game_category.dart`
            - `package:putu_education/data/providers/score_provider.dart`
          </details>

    - 📁 **model**
      - 📄 `presentation/game/model/calculate_history.dart`
          <details>
            <summary>Imports</summary>

            - `package:putu_education/presentation/game/math/calculate_game.dart`
          </details>

      - 📄 `presentation/game/model/question_result.dart`
      - 📄 `presentation/game/model/word_item.dart`
    - 📁 **myanmar**
      - 📄 `presentation/game/myanmar/myanmar.dart`
          <details>
            <summary>Imports</summary>

            - `package:flutter/material.dart`
          </details>

    - 📁 **widgets**
      - 📄 `presentation/game/widgets/back_flip_card.dart`
          <details>
            <summary>Imports</summary>

            - `package:cached_network_image/cached_network_image.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/widgets/front_flip_card_item.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/color_resources.dart`
            - `package:cached_network_image/cached_network_image.dart`
            - `package:flutter/material.dart`
          </details>

      - 📄 `presentation/game/widgets/progress_bar.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `package:flutter/material.dart`
          </details>

      - 📄 `presentation/game/widgets/quit_alert.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_icon.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/widgets/result_view.dart`
          <details>
            <summary>Imports</summary>

            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:go_router/go_router.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/widgets/title_item.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/item_decoration.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/cupertino.dart`
            - `package:flutter/material.dart`
            - `package:go_router/go_router.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

      - 📄 `presentation/game/widgets/voice_item.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/my_icon.dart`
            - `package:flutter/material.dart`
            - `package:flutter_tts/flutter_tts.dart`
          </details>

  - 📁 **home**
    - 📄 `presentation/home/b_home.dart`
  - 📁 **introduction**
    - 📄 `presentation/introduction/introduction.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:flutter/widgets.dart`
          - `package:flutter_svg/svg.dart`
          - `package:go_router/go_router.dart`
          - `package:putu_education/app/config/config.dart`
          - `package:putu_education/presentation/widgets/item_decoration.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

  - 📁 **math**
    - 📁 **calculation**
      - 📄 `presentation/math/calculation/addition_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/item_decoration.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/presentation/math/calculation/widgets/example_item.dart`
          </details>

      - 📄 `presentation/math/calculation/calculation_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/my_appbar.dart`
            - `multiplication_view.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/math/calculation/addition_view.dart`
            - `package:putu_education/presentation/math/calculation/division_view.dart`
            - `package:putu_education/presentation/math/calculation/substraction_view.dart`
            - `package:putu_education/presentation/widgets/item_decoration.dart`
          </details>

      - 📄 `presentation/math/calculation/division_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/item_decoration.dart`
            - `package:flutter/material.dart`
            - `package:flutter_svg/svg.dart`
          </details>

      - 📄 `presentation/math/calculation/multiplication_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/item_decoration.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
          </details>

      - 📄 `presentation/math/calculation/substraction_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/config/config.dart`
            - `../../widgets/item_decoration.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:putu_education/presentation/math/calculation/widgets/example_item.dart`
          </details>

      - 📁 **widgets**
        - 📄 `presentation/math/calculation/widgets/example_item.dart`
            <details>
              <summary>Imports</summary>

              - `../../../../app/config/config.dart`
              - `package:easy_localization/easy_localization.dart`
              - `package:flutter/cupertino.dart`
              - `package:flutter/material.dart`
            </details>

    - 📄 `presentation/math/math_view.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `../../route/route_name.dart`
          - `../widgets/my_appbar.dart`
          - `../widgets/sub_item_widget.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:go_router/go_router.dart`
          - `package:lottie/lottie.dart`
          - `package:putu_education/app/utils/en_types.dart`
          - `package:putu_education/presentation/math/shape/shape_view.dart`
        </details>

    - 📁 **shape**
      - 📄 `presentation/math/shape/shape_painter.dart`
          <details>
            <summary>Imports</summary>

            - `dart:math`
            - `package:flutter/cupertino.dart`
          </details>

      - 📄 `presentation/math/shape/shape_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/my_appbar.dart`
            - `../../widgets/my_icon.dart`
            - `dart:convert`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter/services.dart`
            - `package:flutter_svg/svg.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/widgets/item_decoration.dart`
          </details>

  - 📁 **myanmar**
    - 📁 **alphabet**
      - 📄 `presentation/myanmar/alphabet/alphabet_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../widgets/item_decoration.dart`
            - `../../widgets/my_appbar.dart`
            - `../../widgets/my_icon.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:just_audio/just_audio.dart`
            - `package:putu_education/app/config/config.dart`
          </details>

    - 📄 `presentation/myanmar/myanmar_view.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/font_family.dart`
          - `../../app/utils/en_types.dart`
          - `../math/math_view.dart`
          - `../widgets/my_appbar.dart`
          - `../widgets/my_icon.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:flutter_svg/svg.dart`
          - `package:go_router/go_router.dart`
          - `package:lottie/lottie.dart`
          - `package:putu_education/app/config/color_resources.dart`
          - `package:putu_education/app/config/widget_extensions.dart`
          - `package:putu_education/presentation/widgets/sub_item_widget.dart`
          - `package:putu_education/route/my_router.dart`
        </details>

    - 📁 **number**
      - 📄 `presentation/myanmar/number/number_view.dart`
          <details>
            <summary>Imports</summary>

            - `../../../app/service/tts_service.dart`
            - `../../widgets/my_icon.dart`
            - `package:easy_localization/easy_localization.dart`
            - `package:flutter/material.dart`
            - `package:flutter_tts/flutter_tts.dart`
            - `package:putu_education/app/config/config.dart`
            - `package:putu_education/presentation/widgets/go_button.dart`
            - `package:putu_education/presentation/widgets/item_decoration.dart`
            - `package:putu_education/presentation/widgets/my_appbar.dart`
          </details>

  - 📁 **onboarding**
    - 📄 `presentation/onboarding/screen_one.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

  - 📁 **search**
    - 📄 `presentation/search/search_item.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
        </details>

    - 📄 `presentation/search/search_view.dart`
        <details>
          <summary>Imports</summary>

          - `dart:convert`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:flutter/services.dart`
          - `package:flutter_svg/svg.dart`
          - `package:go_router/go_router.dart`
          - `package:putu_education/app/config/config.dart`
          - `package:putu_education/presentation/math/shape/shape_view.dart`
          - `package:putu_education/presentation/widgets/my_appbar.dart`
          - `package:putu_education/presentation/widgets/my_icon.dart`
          - `package:putu_education/route/my_router.dart`
          - `search_item.dart`
        </details>

  - 📁 **settings**
    - 📄 `presentation/settings/b_settings.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/color_resources.dart`
          - `../../app/config/config.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:provider/provider.dart`
          - `package:putu_education/app/config/widget_extensions.dart`
        </details>

  - 📁 **test**
    - 📄 `presentation/test/phone_number.dart`
        <details>
          <summary>Imports</summary>

          - `dart:async`
          - `package:flutter/material.dart`
        </details>

  - 📁 **widgets**
    - 📄 `presentation/widgets/go_button.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
          - `package:flutter_svg/svg.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

    - 📄 `presentation/widgets/item_decoration.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `package:flutter/material.dart`
        </details>

    - 📄 `presentation/widgets/item_voice_dialog.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `../../app/service/tts_service.dart`
          - `my_icon.dart`
          - `package:cached_network_image/cached_network_image.dart`
          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:flutter_tts/flutter_tts.dart`
        </details>

    - 📄 `presentation/widgets/item_voice_widget.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/service/tts_service.dart`
          - `my_icon.dart`
          - `package:cached_network_image/cached_network_image.dart`
          - `package:flutter/cupertino.dart`
          - `package:flutter/material.dart`
          - `package:flutter_tts/flutter_tts.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

    - 📄 `presentation/widgets/my_appbar.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/config.dart`
          - `package:easy_localization/easy_localization.dart`
          - `package:flutter/material.dart`
          - `package:go_router/go_router.dart`
          - `package:putu_education/presentation/widgets/my_icon.dart`
        </details>

    - 📄 `presentation/widgets/my_icon.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/color_resources.dart`
          - `package:flutter/material.dart`
          - `package:flutter_svg/svg.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

    - 📄 `presentation/widgets/overlay_photo.dart`
        <details>
          <summary>Imports</summary>

          - `../../app/config/color_resources.dart`
          - `dart:io`
          - `dart:typed_data`
          - `package:cached_network_image/cached_network_image.dart`
          - `package:flutter/material.dart`
          - `package:photo_view/photo_view.dart`
        </details>

    - 📄 `presentation/widgets/sub_item_widget.dart`
        <details>
          <summary>Imports</summary>

          - `package:flutter/material.dart`
          - `package:flutter_svg/svg.dart`
          - `package:flutter_svg_provider/flutter_svg_provider.dart`
          - `package:go_router/go_router.dart`
          - `package:putu_education/app/config/config.dart`
        </details>

- 📁 **route**
  - 📄 `route/my_router.dart`
  - 📄 `route/route.dart`
      <details>
        <summary>Imports</summary>

        - `../presentation/english/english_view.dart`
        - `../presentation/english/poem/poem_view.dart`
        - `../presentation/myanmar/alphabet/alphabet_view.dart`
        - `../presentation/myanmar/myanmar_view.dart`
        - `package:flutter/material.dart`
        - `package:go_router/go_router.dart`
        - `package:putu_education/presentation/dashboard/dashboard.dart`
        - `package:putu_education/presentation/dashboard/language_selection.dart`
        - `package:putu_education/presentation/english/alphabet/alphabet_view.dart`
        - `package:putu_education/presentation/english/number/number_view.dart`
        - `package:putu_education/presentation/english/poem/poem_detail.dart`
        - `package:putu_education/presentation/english/vocabulary/vocabulary_view.dart`
        - `package:putu_education/presentation/game/english/english.dart`
        - `package:putu_education/presentation/game/english/sentence_sort_game.dart`
        - `package:putu_education/presentation/game/english/word_game.dart`
        - `package:putu_education/presentation/game/english/word_sort_game.dart`
        - `package:putu_education/presentation/game/math/calculate_game.dart`
        - `package:putu_education/presentation/game/math/counting_game.dart`
        - `package:putu_education/presentation/game/math/math.dart`
        - `package:putu_education/presentation/game/myanmar/myanmar.dart`
        - `package:putu_education/presentation/game/widgets/result_view.dart`
        - `package:putu_education/presentation/introduction/introduction.dart`
        - `package:putu_education/presentation/math/calculation/calculation_view.dart`
        - `package:putu_education/presentation/math/shape/shape_view.dart`
        - `package:putu_education/presentation/myanmar/number/number_view.dart`
        - `package:putu_education/presentation/search/search_view.dart`
        - `package:putu_education/route/route_name.dart`
        - `package:putu_education/route/route_path.dart`
      </details>

  - 📄 `route/route_name.dart`
  - 📄 `route/route_path.dart`

## Project Type

- **Project Type:** monorepo
- **Indicators:**
  - Found 42 pubspec.yaml files (monorepo indicator)
  - Found `flutter` key in pubspec.yaml


## Detected Frameworks

| Framework | In pubspec | Files using it |
|-----------|-----------|----------------|
| Dio | Yes | 1 |
| Provider | Yes | 15 |
| GoRouter | Yes | 20 |


## Architecture

### Detected Layers

- **Widget** (22 files)
- **Model** (8 files)
- **Utility** (3 files)
- **Provider** (3 files)
- **Service** (2 files)
- **Data** (2 files)
- **Presentation** (1 file)

### Entry Points

- `lib/lib/main.dart`

### Layer Dependencies

- Provider → Model
- Service → Data
- Widget → Data, Service



## Project Statistics

- Total Files: 117
- Dart Files: 117
- Total Lines of Dart Code: 12509
- Largest File: `lib/search/search_view.dart` with 574 lines
- Smallest File: `lib/widgets/empty_widget.dart` with 1 lines


## TODO and FIXME Comments

File: lib/refresh_builder/refresh_ui_builder.dart
  - Line 430: // TODO: implement wantKeepAlive

File: lib/dashboard/dashboard.dart
  - Line 45: // TODO: implement initState

File: lib/alphabet/alphabet_view.dart
  - Line 31: // TODO: implement initState

File: lib/number/number_view.dart
  - Line 39: // TODO: implement initState
  - Line 141: // TODO: implement initState

File: lib/english/sentence_sort_game.dart
  - Line 66: // TODO: implement initState

File: lib/english/word_sort_game.dart
  - Line 53: // TODO: implement initState

File: lib/math/calculate_game.dart
  - Line 66: // TODO: implement initState

File: lib/math/counting_game.dart
  - Line 103: // TODO: implement initState

File: lib/widgets/voice_item.dart
  - Line 21: // TODO: implement initState

File: lib/widgets/my_appbar.dart
  - Line 104: // TODO: implement preferredSize

File: lib/widgets/overlay_photo.dart
  - Line 15: // TODO: implement barrierColor
  - Line 19: // TODO: implement barrierDismissible
  - Line 23: // TODO: implement barrierLabel
  - Line 27: // TODO: implement maintainState
  - Line 31: // TODO: implement opaque
  - Line 35: // TODO: implement transitionDuration
  - Line 40: // TODO: implement buildPage



## Dependency Analysis

Package: flutter
Used in:
  - lib/config/color_resources.dart
  - lib/config/font_family.dart
  - lib/config/font_size.dart
  - lib/config/global_context.dart
  - lib/config/theme.dart
  - lib/config/widget_extensions.dart
  - lib/app/typedef_factory.dart
  - lib/utils/device_checker.dart
  - lib/err_state_widget/connection_timeout_widget.dart
  - lib/err_state_widget/maintain_widget.dart
  - lib/err_state_widget/no_data_widget.dart
  - lib/err_state_widget/no_internet_widget.dart
  - lib/err_state_widget/not_found_widget.dart
  - lib/err_state_widget/server_err_widget.dart
  - lib/err_state_widget/too_many_request_widget.dart
  - lib/err_state_widget/unknown_err_widget.dart
  - lib/widgets/err_widget.dart
  - lib/widgets/loading_widgets.dart
  - lib/widgets/more_widget.dart
  - lib/widgets/my_button.dart
  - lib/widgets/my_card.dart
  - lib/external_refresh_builder/external_refresh_ui_builder.dart
  - lib/providers/score_provider.dart
  - lib/providers/settings_info_provider.dart
  - lib/providers/timer_info_provider.dart
  - lib/refresh_builder/refresh_ui_builder.dart
  - lib/single_ui_builder/single_ui_builder.dart
  - lib/lib/main.dart
  - lib/dashboard/dashboard.dart
  - lib/dashboard/language_selection.dart
  - lib/dashboard/lessons_view.dart
  - lib/dashboard/progress_indicator.dart
  - lib/alphabet/alphabet_view.dart
  - lib/english/english_view.dart
  - lib/number/number_view.dart
  - lib/poem/player_widget.dart
  - lib/poem/poem_detail.dart
  - lib/poem/poem_view.dart
  - lib/vocabulary/vocabulary_view.dart
  - lib/english/english.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/sort_result.dart
  - lib/english/word_game.dart
  - lib/english/word_result.dart
  - lib/english/word_sort_game.dart
  - lib/calculate/calculation_result.dart
  - lib/calculate/digit_plus_minus.dart
  - lib/calculate/icon_mul_div.dart
  - lib/calculate/icon_plus_minus.dart
  - lib/calculate/text_widget.dart
  - lib/calculate/what_is.dart
  - lib/math/calculate_game.dart
  - lib/counting/counting_result.dart
  - lib/math/counting_game.dart
  - lib/math/math.dart
  - lib/myanmar/myanmar.dart
  - lib/widgets/back_flip_card.dart
  - lib/widgets/front_flip_card_item.dart
  - lib/widgets/progress_bar.dart
  - lib/widgets/quit_alert.dart
  - lib/widgets/result_view.dart
  - lib/widgets/title_item.dart
  - lib/widgets/voice_item.dart
  - lib/introduction/introduction.dart
  - lib/calculation/addition_view.dart
  - lib/calculation/calculation_view.dart
  - lib/calculation/division_view.dart
  - lib/calculation/multiplication_view.dart
  - lib/calculation/substraction_view.dart
  - lib/widgets/example_item.dart
  - lib/math/math_view.dart
  - lib/shape/shape_painter.dart
  - lib/shape/shape_view.dart
  - lib/myanmar/myanmar_view.dart
  - lib/onboarding/screen_one.dart
  - lib/search/search_item.dart
  - lib/search/search_view.dart
  - lib/settings/b_settings.dart
  - lib/test/phone_number.dart
  - lib/widgets/go_button.dart
  - lib/widgets/item_decoration.dart
  - lib/widgets/item_voice_dialog.dart
  - lib/widgets/item_voice_widget.dart
  - lib/widgets/my_appbar.dart
  - lib/widgets/my_icon.dart
  - lib/widgets/overlay_photo.dart
  - lib/widgets/sub_item_widget.dart
  - lib/route/route.dart

Package: easy_localization
Used in:
  - lib/config/font_family.dart
  - lib/config/font_size.dart
  - lib/err_state_widget/no_data_widget.dart
  - lib/refresh_builder/refresh_ui_builder.dart
  - lib/lib/main.dart
  - lib/dashboard/dashboard.dart
  - lib/dashboard/language_selection.dart
  - lib/dashboard/lessons_view.dart
  - lib/dashboard/progress_indicator.dart
  - lib/alphabet/alphabet_view.dart
  - lib/english/english_view.dart
  - lib/number/number_view.dart
  - lib/poem/poem_view.dart
  - lib/vocabulary/vocabulary_view.dart
  - lib/english/english.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/sort_result.dart
  - lib/english/word_game.dart
  - lib/english/word_sort_game.dart
  - lib/calculate/calculation_result.dart
  - lib/calculate/text_widget.dart
  - lib/math/calculate_game.dart
  - lib/counting/counting_result.dart
  - lib/math/counting_game.dart
  - lib/math/math.dart
  - lib/widgets/quit_alert.dart
  - lib/widgets/result_view.dart
  - lib/widgets/title_item.dart
  - lib/calculation/addition_view.dart
  - lib/calculation/calculation_view.dart
  - lib/calculation/multiplication_view.dart
  - lib/calculation/substraction_view.dart
  - lib/widgets/example_item.dart
  - lib/math/math_view.dart
  - lib/shape/shape_view.dart
  - lib/myanmar/myanmar_view.dart
  - lib/search/search_view.dart
  - lib/settings/b_settings.dart
  - lib/widgets/my_appbar.dart

Package: putu_education
Used in:
  - lib/config/font_size.dart
  - lib/err_state_widget/no_internet_widget.dart
  - lib/model/response_ob.dart
  - lib/refresh_builder/refresh_ui_builder.dart
  - lib/lib/main.dart
  - lib/dashboard/dashboard.dart
  - lib/dashboard/language_selection.dart
  - lib/dashboard/lessons_view.dart
  - lib/dashboard/progress_indicator.dart
  - lib/alphabet/alphabet_view.dart
  - lib/english/english_view.dart
  - lib/number/number_view.dart
  - lib/poem/player_widget.dart
  - lib/poem/poem_detail.dart
  - lib/poem/poem_view.dart
  - lib/vocabulary/vocabulary_view.dart
  - lib/english/english.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/sort_result.dart
  - lib/english/word_game.dart
  - lib/english/word_result.dart
  - lib/english/word_sort_game.dart
  - lib/calculate/calculation_result.dart
  - lib/calculate/digit_plus_minus.dart
  - lib/calculate/icon_mul_div.dart
  - lib/calculate/icon_plus_minus.dart
  - lib/calculate/text_widget.dart
  - lib/math/calculate_game.dart
  - lib/counting/counting_result.dart
  - lib/math/counting_game.dart
  - lib/math/math.dart
  - lib/model/calculate_history.dart
  - lib/widgets/back_flip_card.dart
  - lib/widgets/quit_alert.dart
  - lib/widgets/result_view.dart
  - lib/widgets/title_item.dart
  - lib/introduction/introduction.dart
  - lib/calculation/addition_view.dart
  - lib/calculation/calculation_view.dart
  - lib/calculation/substraction_view.dart
  - lib/math/math_view.dart
  - lib/shape/shape_view.dart
  - lib/myanmar/myanmar_view.dart
  - lib/onboarding/screen_one.dart
  - lib/search/search_view.dart
  - lib/settings/b_settings.dart
  - lib/widgets/go_button.dart
  - lib/widgets/item_voice_widget.dart
  - lib/widgets/my_appbar.dart
  - lib/widgets/my_icon.dart
  - lib/widgets/sub_item_widget.dart
  - lib/route/route.dart

Package: get_it
Used in:
  - lib/service/locator.dart
  - lib/dashboard/dashboard.dart

Package: flutter_tts
Used in:
  - lib/service/tts_service.dart
  - lib/alphabet/alphabet_view.dart
  - lib/number/number_view.dart
  - lib/vocabulary/vocabulary_view.dart
  - lib/english/word_game.dart
  - lib/widgets/voice_item.dart
  - lib/widgets/item_voice_dialog.dart
  - lib/widgets/item_voice_widget.dart

Package: device_info_plus
Used in:
  - lib/utils/device_checker.dart

Package: lottie
Used in:
  - lib/err_state_widget/no_internet_widget.dart
  - lib/widgets/loading_widgets.dart
  - lib/dashboard/dashboard.dart
  - lib/dashboard/lessons_view.dart
  - lib/english/english_view.dart
  - lib/math/math_view.dart
  - lib/myanmar/myanmar_view.dart

Package: rxdart
Used in:
  - lib/external_refresh_builder/external_refresh_ui_bloc.dart
  - lib/refresh_builder/refresh_ui_bloc.dart
  - lib/single_ui_builder/single_ui_bloc.dart

Package: pull_to_refresh
Used in:
  - lib/external_refresh_builder/external_refresh_ui_builder.dart
  - lib/refresh_builder/refresh_ui_builder.dart

Package: path_provider
Used in:
  - lib/providers/score_provider.dart

Package: shared_preferences
Used in:
  - lib/providers/score_provider.dart

Package: flutter_easyloading
Used in:
  - lib/lib/main.dart

Package: provider
Used in:
  - lib/lib/main.dart
  - lib/dashboard/language_selection.dart
  - lib/dashboard/progress_indicator.dart
  - lib/alphabet/alphabet_view.dart
  - lib/english/english.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/word_game.dart
  - lib/english/word_sort_game.dart
  - lib/math/calculate_game.dart
  - lib/math/counting_game.dart
  - lib/math/math.dart
  - lib/settings/b_settings.dart

Package: dio
Used in:
  - lib/network/dio_basenetwork.dart

Package: flutter_statusbarcolor_ns
Used in:
  - lib/dashboard/dashboard.dart

Package: go_router
Used in:
  - lib/dashboard/dashboard.dart
  - lib/dashboard/language_selection.dart
  - lib/dashboard/lessons_view.dart
  - lib/dashboard/progress_indicator.dart
  - lib/english/english_view.dart
  - lib/poem/poem_view.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/word_game.dart
  - lib/english/word_sort_game.dart
  - lib/math/calculate_game.dart
  - lib/math/counting_game.dart
  - lib/widgets/result_view.dart
  - lib/widgets/title_item.dart
  - lib/introduction/introduction.dart
  - lib/math/math_view.dart
  - lib/myanmar/myanmar_view.dart
  - lib/search/search_view.dart
  - lib/widgets/my_appbar.dart
  - lib/widgets/sub_item_widget.dart
  - lib/route/route.dart

Package: audioplayers
Used in:
  - lib/poem/player_widget.dart
  - lib/poem/poem_detail.dart

Package: cached_network_image
Used in:
  - lib/poem/player_widget.dart
  - lib/poem/poem_view.dart
  - lib/english/word_result.dart
  - lib/widgets/back_flip_card.dart
  - lib/widgets/front_flip_card_item.dart
  - lib/widgets/item_voice_dialog.dart
  - lib/widgets/item_voice_widget.dart
  - lib/widgets/overlay_photo.dart

Package: flutter_svg
Used in:
  - lib/poem/player_widget.dart
  - lib/poem/poem_view.dart
  - lib/english/sentence_sort_game.dart
  - lib/english/word_game.dart
  - lib/english/word_sort_game.dart
  - lib/calculate/icon_mul_div.dart
  - lib/calculate/icon_plus_minus.dart
  - lib/math/calculate_game.dart
  - lib/math/counting_game.dart
  - lib/introduction/introduction.dart
  - lib/calculation/calculation_view.dart
  - lib/calculation/division_view.dart
  - lib/shape/shape_view.dart
  - lib/myanmar/myanmar_view.dart
  - lib/search/search_view.dart
  - lib/widgets/go_button.dart
  - lib/widgets/my_icon.dart
  - lib/widgets/sub_item_widget.dart

Package: just_audio
Used in:
  - lib/alphabet/alphabet_view.dart

Package: photo_view
Used in:
  - lib/widgets/overlay_photo.dart

Package: flutter_svg_provider
Used in:
  - lib/widgets/sub_item_widget.dart



## Code Metrics

File: lib/config/api_constants.dart
  Lines of Code: 15
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/color_resources.dart
  Lines of Code: 39
  Classes: 1
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/config.dart
  Lines of Code: 8
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/font_family.dart
  Lines of Code: 34
  Classes: 1
  Methods: 5
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/font_size.dart
  Lines of Code: 72
  Classes: 1
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/global_context.dart
  Lines of Code: 8
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/theme.dart
  Lines of Code: 62
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/config/widget_extensions.dart
  Lines of Code: 56
  Classes: 0
  Methods: 6
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/service/locator.dart
  Lines of Code: 17
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/service/tts_service.dart
  Lines of Code: 31
  Classes: 1
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/app/typedef_factory.dart
  Lines of Code: 10
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/utils/ad_helper.dart
  Lines of Code: 36
  Classes: 1
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/utils/device_checker.dart
  Lines of Code: 51
  Classes: 1
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/utils/en_types.dart
  Lines of Code: 2
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/empty_widget.dart
  Lines of Code: 2
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/connection_timeout_widget.dart
  Lines of Code: 42
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/maintain_widget.dart
  Lines of Code: 30
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/no_data_widget.dart
  Lines of Code: 38
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/no_internet_widget.dart
  Lines of Code: 84
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/not_found_widget.dart
  Lines of Code: 36
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/server_err_widget.dart
  Lines of Code: 45
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/too_many_request_widget.dart
  Lines of Code: 28
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/err_state_widget/unknown_err_widget.dart
  Lines of Code: 66
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/err_widget.dart
  Lines of Code: 71
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/loading_widgets.dart
  Lines of Code: 71
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/more_widget.dart
  Lines of Code: 83
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/my_button.dart
  Lines of Code: 33
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/my_card.dart
  Lines of Code: 98
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/external_refresh_builder/external_refresh_ui_bloc.dart
  Lines of Code: 117
  Classes: 1
  Methods: 6
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/external_refresh_builder/external_refresh_ui_builder.dart
  Lines of Code: 336
  Classes: 2
  Methods: 8
  Comment Lines: 12
  Comment Ratio: 3.57%

File: lib/model/game_category.dart
  Lines of Code: 3
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/music_ob_class.dart
  Lines of Code: 40
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/paginate_ob.dart
  Lines of Code: 60
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/pn_ob_class.dart
  Lines of Code: 141
  Classes: 3
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/response_ob.dart
  Lines of Code: 77
  Classes: 2
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/data/model_factory.dart
  Lines of Code: 23
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/providers/score_provider.dart
  Lines of Code: 174
  Classes: 1
  Methods: 14
  Comment Lines: 15
  Comment Ratio: 8.62%

File: lib/providers/settings_info_provider.dart
  Lines of Code: 30
  Classes: 1
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/providers/timer_info_provider.dart
  Lines of Code: 16
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/refresh_builder/refresh_ui_bloc.dart
  Lines of Code: 143
  Classes: 1
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/refresh_builder/refresh_ui_builder.dart
  Lines of Code: 433
  Classes: 2
  Methods: 8
  Comment Lines: 15
  Comment Ratio: 3.46%

File: lib/data/shared_prefs_helper.dart
  Lines of Code: 2
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/single_ui_builder/single_ui_bloc.dart
  Lines of Code: 44
  Classes: 1
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/single_ui_builder/single_ui_builder.dart
  Lines of Code: 309
  Classes: 2
  Methods: 6
  Comment Lines: 13
  Comment Ratio: 4.21%

File: lib/lib/main.dart
  Lines of Code: 113
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/network/dio_basenetwork.dart
  Lines of Code: 287
  Classes: 1
  Methods: 5
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/presentation/b_dashboard.dart
  Lines of Code: 169
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/dashboard/dashboard.dart
  Lines of Code: 243
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/dashboard/language_selection.dart
  Lines of Code: 123
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/dashboard/lessons_view.dart
  Lines of Code: 118
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/dashboard/progress_indicator.dart
  Lines of Code: 104
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/alphabet/alphabet_view.dart
  Lines of Code: 151
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/b_english_view.dart
  Lines of Code: 92
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/english_view.dart
  Lines of Code: 135
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/number/number_view.dart
  Lines of Code: 299
  Classes: 2
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/poem/player_widget.dart
  Lines of Code: 386
  Classes: 2
  Methods: 15
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/poem/poem_detail.dart
  Lines of Code: 205
  Classes: 3
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/poem/poem_view.dart
  Lines of Code: 145
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/vocabulary/vocabulary_view.dart
  Lines of Code: 159
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/english.dart
  Lines of Code: 70
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/sentence_sort_game.dart
  Lines of Code: 226
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/sort_result.dart
  Lines of Code: 62
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/word_game.dart
  Lines of Code: 176
  Classes: 2
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/word_result.dart
  Lines of Code: 74
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/english/word_sort_game.dart
  Lines of Code: 213
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/calculation_result.dart
  Lines of Code: 90
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/digit_plus_minus.dart
  Lines of Code: 36
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/icon_mul_div.dart
  Lines of Code: 79
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/icon_plus_minus.dart
  Lines of Code: 90
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/text_widget.dart
  Lines of Code: 16
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculate/what_is.dart
  Lines of Code: 24
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/math/calculate_game.dart
  Lines of Code: 300
  Classes: 2
  Methods: 5
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/counting/counting_result.dart
  Lines of Code: 65
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/math/counting_game.dart
  Lines of Code: 238
  Classes: 2
  Methods: 7
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/math/math.dart
  Lines of Code: 68
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/calculate_history.dart
  Lines of Code: 28
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/question_result.dart
  Lines of Code: 20
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/model/word_item.dart
  Lines of Code: 90
  Classes: 1
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/myanmar/myanmar.dart
  Lines of Code: 17
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/back_flip_card.dart
  Lines of Code: 60
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/front_flip_card_item.dart
  Lines of Code: 41
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/progress_bar.dart
  Lines of Code: 45
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/quit_alert.dart
  Lines of Code: 85
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/result_view.dart
  Lines of Code: 163
  Classes: 2
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/title_item.dart
  Lines of Code: 124
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/voice_item.dart
  Lines of Code: 57
  Classes: 2
  Methods: 5
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/home/b_home.dart
  Lines of Code: 241
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/introduction/introduction.dart
  Lines of Code: 97
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculation/addition_view.dart
  Lines of Code: 204
  Classes: 3
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculation/calculation_view.dart
  Lines of Code: 109
  Classes: 2
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculation/division_view.dart
  Lines of Code: 229
  Classes: 3
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculation/multiplication_view.dart
  Lines of Code: 112
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/calculation/substraction_view.dart
  Lines of Code: 203
  Classes: 3
  Methods: 8
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/example_item.dart
  Lines of Code: 93
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/math/math_view.dart
  Lines of Code: 110
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/shape/shape_painter.dart
  Lines of Code: 40
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/shape/shape_view.dart
  Lines of Code: 233
  Classes: 2
  Methods: 7
  Comment Lines: 4
  Comment Ratio: 1.72%

File: lib/myanmar/myanmar_view.dart
  Lines of Code: 128
  Classes: 2
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/onboarding/screen_one.dart
  Lines of Code: 202
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/search/search_item.dart
  Lines of Code: 41
  Classes: 2
  Methods: 0
  Comment Lines: 2
  Comment Ratio: 4.88%

File: lib/search/search_view.dart
  Lines of Code: 575
  Classes: 2
  Methods: 22
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/settings/b_settings.dart
  Lines of Code: 121
  Classes: 2
  Methods: 3
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/test/phone_number.dart
  Lines of Code: 187
  Classes: 2
  Methods: 4
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/go_button.dart
  Lines of Code: 28
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/item_decoration.dart
  Lines of Code: 51
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/item_voice_dialog.dart
  Lines of Code: 134
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/item_voice_widget.dart
  Lines of Code: 95
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/my_appbar.dart
  Lines of Code: 107
  Classes: 1
  Methods: 2
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/my_icon.dart
  Lines of Code: 55
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/overlay_photo.dart
  Lines of Code: 89
  Classes: 1
  Methods: 7
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/widgets/sub_item_widget.dart
  Lines of Code: 91
  Classes: 1
  Methods: 1
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/route/my_router.dart
  Lines of Code: 4
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/route/route.dart
  Lines of Code: 234
  Classes: 0
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/route/route_name.dart
  Lines of Code: 31
  Classes: 1
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%

File: lib/route/route_path.dart
  Lines of Code: 31
  Classes: 1
  Methods: 0
  Comment Lines: 0
  Comment Ratio: 0.00%



## Naming Conventions

- Files following suffix convention: 43/117 (36.8%)

### File Naming Conventions

| Suffix | Count |
|--------|-------|
| `_view` | 19 |
| `_widget` | 15 |
| `_bloc` | 3 |
| `_provider` | 3 |
| `_helper` | 2 |
| `_service` | 1 |

### Class Naming Conventions

| Suffix | Count |
|--------|-------|
| `State` | 37 |
| `View` | 36 |
| `Widget` | 16 |
| `Bloc` | 3 |
| `Model` | 3 |
| `Provider` | 3 |
| `Service` | 1 |
| `Helper` | 1 |
| `Page` | 1 |



## File Purposes

### Purpose Summary

| Purpose | Count |
|---------|-------|
| widget | 76 |
| other | 19 |
| model | 8 |
| bloc | 3 |
| provider | 3 |
| service | 2 |
| helper | 2 |
| utility | 2 |
| view | 1 |
| test | 1 |

*115 files analyzed — detailed list omitted for brevity.*



## Aggregated Metrics

- Total Classes: 139
- Total Methods: 311
- Average LOC per file: 106.8
- Average Comment Ratio: 0.5%
- Files without comments: 109

### Largest Files (Top 5)

1. `lib/search/search_view.dart` - 575 lines
2. `lib/refresh_builder/refresh_ui_builder.dart` - 433 lines
3. `lib/poem/player_widget.dart` - 386 lines
4. `lib/external_refresh_builder/external_refresh_ui_builder.dart` - 336 lines
5. `lib/single_ui_builder/single_ui_builder.dart` - 309 lines


