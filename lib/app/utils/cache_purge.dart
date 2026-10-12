// Path: app/utils/cache_purge.dart
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // App updated -> wipe every cache entry (numbers included), then record the version.
  final version = (await PackageInfo.fromPlatform()).version;
  final updated = prefs.getString(_versionKey) != version;
  if (updated) await prefs.setString(_versionKey, version);
  for (final tsKey in prefs.getKeys().where((k) => k.endsWith('_ts')).toList()) {
    final key = tsKey.substring(0, tsKey.length - 3);
    if (updated) {
      await prefs.remove(key);
      await prefs.remove(tsKey);
      continue;
    }
    final prefix = cacheTtls.keys.where(key.startsWith).firstOrNull;
    final ts = prefs.getInt(tsKey);
    if (prefix == null || ts == null) continue;
    if (now - ts > cacheTtls[prefix]!.inMilliseconds) {
      await prefs.remove(key);
      await prefs.remove(tsKey);
    }
  }
}
