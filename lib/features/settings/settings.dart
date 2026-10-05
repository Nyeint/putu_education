import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:putu_education/features/settings/language_selection.dart';

import '../../app/config/color_resources.dart';
import '../../app/config/widget_extensions.dart';
import '../../app/service/locator.dart';
import 'bloc/check_update_bloc.dart';
import 'check_update_dialog.dart';
import 'about_putu.dart';
import 'contact_us.dart';
import '../widgets/my_appbar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final CheckUpdateBloc _bloc = getIt<CheckUpdateBloc>();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.locale.languageCode == 'en';
    return BlocListener<CheckUpdateBloc, CheckUpdateState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CheckUpdateSuccess) {
          showCheckUpdateDialog(context, state.data);
        } else if (state is CheckUpdateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Could not check for updates. Please try again.')),
          );
        }
      },
      child: _buildScaffold(context, isEn),
    );
  }

  Widget _buildScaffold(BuildContext context, bool isEn) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Container(
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/settings_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            MyAppBar(
              titleWithGoBack: 'Settings',
            ),
            const SizedBox(height: 28),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _Tile(
                    icon: Icons.language,
                    color: const Color(0xFF42A5F5),
                    title: tr('language'),
                    subtitle: 'English / မြန်မာ',
                    // onTap: () => context.setLocale(isEn
                    //     ? const Locale('my', 'MM')
                    //     : const Locale('en', 'US')),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LanguageSelectionView()));
                    },
                  ),
                  _Tile(
                    icon: Icons.sync,
                    color: const Color(0xFF4CAF50),
                    title: tr('check_for_update'),
                    subtitle: tr('tap_for_check_version'),
                    onTap: () => _bloc.add(const CheckUpdateEvent()),
                  ),
                  _Tile(
                    icon: Icons.mail_rounded,
                    color: const Color(0xFFF5A623),
                    title: tr('contact_us'),
                    subtitle: tr('contact_us_description'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsView())),
                  ),
                  _Tile(
                    icon: Icons.info_outline_rounded,
                    color: const Color(0xFFE5576B),
                    title: tr('about_putu'),
                    subtitle: tr('about_putu_description'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPutuView())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.highlighted = false,
  });

  final IconData icon;
  final Color color;
  final String title, subtitle;
  final VoidCallback? onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white.withValues(alpha: 0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: highlighted
              ? const BorderSide(color: Color(0xFFF0922B), width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(18)),
                  child: Icon(icon, color: Colors.white, size: 34),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFFC98B3A), size: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
