import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app/config/color_resources.dart';
import '../../app/config/widget_extensions.dart';
import '../widgets/my_appbar.dart';
import 'contact_us.dart';

class AboutPutuView extends StatelessWidget {
  const AboutPutuView({super.key});

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
            MyAppBar(titleWithGoBack: 'About PuTu'),
            const SizedBox(height: 28),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset('assets/icons/putu_logo.png', width: 110, height: 110),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('PuTu – Learn & Play',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 4),
                                  FutureBuilder<PackageInfo>(
                                    future: PackageInfo.fromPlatform(),
                                    builder: (_, snap) => Text(
                                      'Version ${snap.data?.version ?? ''}',
                                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'A fun learning app for kids to explore languages, words, numbers and more.',
                                    style: TextStyle(fontSize: 16, height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const ContactUsView()));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1E9DC),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(TextSpan(children: [
                                        TextSpan(text: 'Developed with '),
                                        WidgetSpan(child: Icon(Icons.favorite, color: Color(0xFFE5576B), size: 20)),
                                      ]), style: TextStyle(fontSize: 16)),
                                      SizedBox(height: 4),
                                      Text('by PuTu Team', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right_rounded, color: Color(0xFFC98B3A), size: 32),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
