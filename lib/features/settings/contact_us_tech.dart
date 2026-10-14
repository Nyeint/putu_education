import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/config/color_resources.dart';
import '../../app/config/widget_extensions.dart';
import '../widgets/my_appbar.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Container(
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/settings_bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            MyAppBar(titleWithGoBack: tr('contact_us')),
            const SizedBox(height: 28),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _ContactTile(
                    icon: Icon(Icons.mail_rounded, color: Colors.white, size: 34),
                    color: Color(0xFF4FA3F7),
                    title: 'Email Us',
                    subtitle: 'putu.learn@gmail.com',
                    url: 'putu.learn@gmail.com',
                    // subtitle: 'litobird.tech@gmail.com',
                    // url: 'litobird.tech@gmail.com',
                  ),
                  _ContactTile(
                    icon: Text('f', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
                    color: Color(0xFF1877F2),
                    title: 'Facebook Page',
                    subtitle: 'PuTu - ပုတု',
                    url: 'https://www.facebook.com/putu.education',
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

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.url,
  });

  final Widget icon;
  final Color color;
  final String title, subtitle, url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white.withValues(alpha: 0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
                  child: icon,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 15, color: Colors.black54)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Color(0xFFC98B3A), size: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
