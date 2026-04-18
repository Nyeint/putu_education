import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/my_icon.dart';

/// Shapes lesson text follows [locale] (learn track: [LearnLanguageType.mm.name] or [LearnLanguageType.en.name]),
/// not the global EasyLocalization locale — so Myanmar math can show Myanmar copy while the app UI stays English.
class ShapeView extends StatefulWidget {
  /// Use `LearnLanguageType.mm.name` (`'mm'`) or `LearnLanguageType.en.name` (`'en'`).
  final String locale;

  const ShapeView({super.key, required this.locale});

  @override
  State<ShapeView> createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  Map<String, dynamic> _strings = {};
  bool _ready = false;

  bool get _useMyanmar =>
      widget.locale == 'mm' || widget.locale == 'my';

  @override
  void initState() {
    super.initState();
    _loadStrings();
  }

  Future<void> _loadStrings() async {
    final assetPath =
        _useMyanmar ? 'languages/my-MM.json' : 'languages/en-US.json';
    try {
      final raw = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (!mounted) return;
      setState(() {
        _strings = decoded is Map<String, dynamic> ? decoded : {};
        _ready = true;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _strings = {};
        _ready = true;
      });
    }
  }

  /// Page-local copy: bundled JSON for this learn language, fallback to [tr] if a key is missing.
  String t(String key) {
    final value = _strings[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return tr(key);
  }

  Widget _itemWidget({
    required BuildContext context,
    required String name,
    required String body,
    required String icon,
  }) {
    return Container(
      width: context.width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: unselectedDecoration(),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/shapes/$icon.svg",
                  color: ColorResources.primary,
                  height: context.width / 4.5,
                ),
                const SizedBox(height: 8),
                Text(
                  name.capitalize(),
                  style: FontFamily()
                      .semiBold
                      .copyWith(fontSize: FontSize().twentyFour),
                ),
                Text(
                  body,
                  style: FontFamily()
                      .regular
                      .copyWith(fontSize: FontSize().eighteen),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: MyIcon(iconName: 'volume'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return Scaffold(
        backgroundColor: ColorResources.background,
        body: Center(
          child: CircularProgressIndicator(color: ColorResources.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: MyAppBar(
        titleWithGoBack: t('shapes'),
      ),
      body: SafeArea(
        child: Container(
          height: context.height,
          width: context.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/light_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _itemWidget(
                  context: context,
                  name: t('triangle'),
                  body: t('triangle_des'),
                  icon: 'triangle',
                ),
                _itemWidget(
                  context: context,
                  name: t('square'),
                  body: t('square_des'),
                  icon: 'square',
                ),
                _itemWidget(
                  context: context,
                  name: t('pentagon'),
                  body: t('pentagon_des'),
                  icon: 'pentagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('hexagon'),
                  body: t('hexagon_des'),
                  icon: 'hexagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('heptagon'),
                  body: t('heptagon_des'),
                  icon: 'heptagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('octagon'),
                  body: t('octagon_des'),
                  icon: 'octagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('nonagon'),
                  body: t('nonagon_des'),
                  icon: 'nonagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('decagon'),
                  body: t('decagon_des'),
                  icon: 'decagon',
                ),
                _itemWidget(
                  context: context,
                  name: t('circle'),
                  body: t('circle_des'),
                  icon: 'circle',
                ),
                _itemWidget(
                  context: context,
                  name: t('semicircle'),
                  body: t('semicircle_des'),
                  icon: 'semicircle',
                ),
                _itemWidget(
                  context: context,
                  name: t('oval'),
                  body: t('oval_des'),
                  icon: 'oval',
                ),
                _itemWidget(
                  context: context,
                  name: t('line'),
                  body: t('line_des'),
                  icon: 'line',
                ),
                _itemWidget(
                  context: context,
                  name: t('parallelogram'),
                  body: t('parallelogram_des'),
                  icon: 'parallelogram',
                ),
              ],
            ).pad(
              left: 16,
              right: 16,
              top: 24,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ),
      ),
    );
  }
}
