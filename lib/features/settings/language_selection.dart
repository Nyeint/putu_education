// Path: settings/language_selection.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:putu_education/app/config/config.dart';

import '../../data/providers/settings_info_provider.dart';
import '../widgets/my_appbar.dart';

const _blue = Color(0xFF3B8FEA);

class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = context.locale.languageCode == 'en';
    void select(Locale locale, Language lang) {
      context.setLocale(locale);
      Provider.of<SettingsInfoProvider>(context, listen: false).language = lang;
    }

    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Container(
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/settings_bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            MyAppBar(titleWithGoBack: tr('language')),
            const SizedBox(height: 28),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text(
                    // tr('which_language'),
                    'Which langauge do you want to use?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF3A1F0B)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'အသုံးပြုမည့် ဘာသာစကားကို ရွေးချယ်ပါ။',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  _LangCard(
                    flag: 'assets/icons/english.png',
                    label: 'English Language',
                    selected: isEn,
                    onTap: () => select(const Locale('en', 'US'), Language.en),
                  ),
                  const SizedBox(height: 16),
                  _LangCard(
                    flag: 'assets/icons/myanmar.png',
                    label: 'မြန်မာ ဘာသာစကား',
                    selected: !isEn,
                    onTap: () => select(const Locale('my', 'MM'), Language.mm),
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

class _LangCard extends StatelessWidget {
  const _LangCard({required this.flag, required this.label, required this.selected, required this.onTap});

  final String flag, label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFDCEBFD) : Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: selected ? Border.all(color: _blue, width: 3) : null,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(flag, width: 50, height: 50, fit: BoxFit.cover),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: selected ? const Color(0xFF1B2F5C) : const Color(0xFF3A1F0B),
                ),
              ),
            ),
            selected
                ? const CircleAvatar(radius: 15, backgroundColor: _blue, child: Icon(Icons.check, color: Colors.white))
                : Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black26, width: 3)),
                  ),
          ],
        ),
      ),
    );
  }
}
