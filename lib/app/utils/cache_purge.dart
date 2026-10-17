// Path: app/utils/cache_purge.dart
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/onboarding/on_boarding.dart' show onboardingSeenKey;

/// Cache key prefix -> max age. Anything not listed (numbers) lives forever.
/// Every cache entry stores its write time under '<key>_ts'.
const cacheTtls = {
  'vocab_': Duration(days: 3),
  'poemtory_cache_': Duration(days: 5), // stories + songs
  'game_cache_': Duration(days: 30),
};

const _versionKey = 'cache_app_version';

Future<void> purgeExpiredCache() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now().millisecondsSinceEpoch;
  // App updated (version name or build number changed) -> wipe all prefs except onboarding.
  final info = await PackageInfo.fromPlatform();
  final version = '${info.version}+${info.buildNumber}';
  if (prefs.getString(_versionKey) != version) {
    for (final k in prefs.getKeys().toList()) {
      if (k != onboardingSeenKey) await prefs.remove(k);
    }
    await prefs.setString(_versionKey, version);
    return;
  }
  for (final tsKey in prefs.getKeys().where((k) => k.endsWith('_ts')).toList()) {
    final key = tsKey.substring(0, tsKey.length - 3);
    final prefix = cacheTtls.keys.where(key.startsWith).firstOrNull;
    final ts = prefs.getInt(tsKey);
    if (prefix == null || ts == null) continue;
    if (now - ts > cacheTtls[prefix]!.inMilliseconds) {
      await prefs.remove(key);
      await prefs.remove(tsKey);
    }
  }
}
