import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/check_update_model.dart';

const _green = Color(0xFF4CAF50);

Future<void> showCheckUpdateDialog(BuildContext context, CheckUpdateData data) {
  final available = data.updateAvailable == true;
  // release_notes may arrive as a list or a newline separated string.
  final notes = data.releaseNotes is List
      ? (data.releaseNotes as List).map((e) => '$e').toList()
      : (data.releaseNotes?.toString() ?? '')
          .split('\n')
          .where((e) => e.trim().isNotEmpty)
          .toList();

  return showDialog(
    context: context,
    barrierDismissible: data.forceUpdate != true,
    builder: (ctx) => Dialog(
      backgroundColor: const Color(0xFFFFFBF2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (data.forceUpdate != true)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFFF3E6CF),
                      child:
                          Icon(Icons.close, size: 18, color: Color(0xFF8A5A1F)),
                    ),
                  ),
                ),
              Image.asset(
                available
                    ? 'assets/icons/checkversion1.png'
                    : 'assets/icons/checkversion2.png',
                height: 150,
              ),
              const SizedBox(height: 12),
              Text(
                available
                    ? 'A new version is available!'
                    : "You're up to date!",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                available
                    ? 'Version ${data.latestVersion} is now available.'
                    : 'You are using the latest version.\nVersion ${data.currentVersion}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              if (available && notes.isNotEmpty) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final n in notes)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 10, color: _green),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Text(n,
                                      style: const TextStyle(fontSize: 15))),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              _Btn(
                label: available ? 'Update Now' : 'OK',
                color: available ? _green : const Color(0xFFFFC928),
                textColor: available ? Colors.white : Colors.black,
                onTap: () async {
                  if (available && data.storeUrl != null) {
                    await launchUrl(Uri.parse('${data.storeUrl}'),
                        mode: LaunchMode.externalApplication);
                  }
                  if (ctx.mounted && !(available && data.forceUpdate == true))
                    Navigator.pop(ctx);
                },
              ),
              if (available) ...[
                const SizedBox(height: 10),
                _Btn(
                  label: 'Later',
                  color: const Color(0xFFFFF0C2),
                  textColor: const Color(0xFF7A4A12),
                  onTap: () => Navigator.pop(ctx),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}

class _Btn extends StatelessWidget {
  const _Btn(
      {required this.label,
      required this.color,
      required this.textColor,
      required this.onTap});

  final String label;
  final Color color, textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: textColor)),
      ),
    );
  }
}
