// Path: poem/poem_detail.dart
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:markdown/markdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/features/topics/presentation/pages/poemtory/player_widget.dart';
import 'package:putu_education/features/topics/data/model/poemtory_list_model.dart';
import '../../../../widgets/my_appbar.dart';
import 'package:markdown/markdown.dart' as markdown;

class PoemToryDetailView extends StatefulWidget {
  PoemToryData data;
  PoemToryDetailView({super.key, required this.data});

  @override
  State<PoemToryDetailView> createState() => _PoemToryDetailViewState();
}

class _PlayerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final AudioPlayer player;
  final double minHeight;
  final double maxHeight;
  final String image;

  _PlayerHeaderDelegate({
    required this.player,
    required this.minHeight,
    required this.maxHeight,
    this.image = '',
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final currentExtent = (maxExtent - shrinkOffset).clamp(minExtent, maxExtent);
    // Only switch to the compact controls when the header is (almost) fully
    // collapsed. If we switch as soon as scroll starts, the header can still be
    // tall while the content is compact, leaving an awkward empty gap.
    final collapseRange = (maxExtent - minExtent).clamp(0.0, double.infinity);
    final fullyCollapsed = collapseRange == 0
        ? true
        : shrinkOffset >= (collapseRange - 1.0); // tolerate tiny rounding

    final topPad = fullyCollapsed ? 8.0 : 16.0;
    final bottomPad = fullyCollapsed ? 8.0 : 12.0;
    // Ensure the header child always occupies the header's current extent.
    // Otherwise, if we render a shorter compact widget while the header is still
    // tall, Flutter can hit: "layoutExtent exceeds paintExtent".
    return SizedBox(
      height: currentExtent,
      child: Material(
        // Keep this header visually separate from the scroll content below.
        // Without an opaque background + clipping, the poem body can appear to
        // scroll "under" the player (especially when the player is compact and
        // has rounded corners).
        color: ColorResources.background,
        elevation: overlapsContent ? 2 : 0,
        clipBehavior: Clip.hardEdge,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: PlayerWidget(
            player: player,
            compact: fullyCollapsed,
            showCompactArtwork: fullyCollapsed,
            imageUrl: image,
          ).pad(left: 16, right: 16, top: topPad, bottom: bottomPad),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PlayerHeaderDelegate oldDelegate) {
    return oldDelegate.player != player ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}

class _PoemToryDetailViewState extends State<PoemToryDetailView> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await player.setSource(AssetSource('ambient_c_motion.mp3'));
      await _loadAndPlay(widget.data.audio ?? '');
    });
  }

  // Streaming the mp3 straight from its URL leaves duration undetectable on
  // some servers (no Content-Length/range support), so getDuration() and
  // onDurationChanged in PlayerWidget never resolve a real value. Downloading
  // the file to local storage first gives the native player full random
  // access to the actual mp3 bytes, so it can read the real duration from the
  // file itself instead of depending on anything the backend reports.
  Future<void> _loadAndPlay(String audioUrl) async {
    if (audioUrl.isEmpty) return;
    try {
      final localPath = await _downloadToCache(audioUrl);
      await player.setSourceDeviceFile(localPath);
    } catch (_) {
      // Fall back to direct streaming if caching the file fails for any
      // reason (e.g. no disk space, offline) so playback still works.
      await player.setSourceUrl(audioUrl);
    }
    await player.resume();
  }

  Future<String> _downloadToCache(String audioUrl) async {
    final dir = await getTemporaryDirectory();
    final ext = audioUrl.split('?').first.split('.').last;
    final fileName = 'poemtory_${audioUrl.hashCode}.$ext';
    final file = File('${dir.path}/$fileName');
    if (!await file.exists() || await file.length() == 0) {
      await Dio().download(audioUrl, file.path);
    }
    return file.path;
  }

  @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const minPlayerHeight = 90.0;
    final computedMax = context.height * 0.45;
    // SliverPersistentHeader requires maxExtent >= minExtent; on small
    // viewports (or when `context.height` is constrained), this can otherwise
    // become invalid and crash with "layoutExtent exceeds paintExtent".
    final maxPlayerHeight = computedMax < minPlayerHeight
        ? minPlayerHeight
        : computedMax.toDouble();
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: widget.data.title ?? '',
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/light_background.png"),
                fit: BoxFit.fill
              ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PlayerHeaderDelegate(
                    player: player,
                    minHeight: minPlayerHeight,
                    maxHeight: maxPlayerHeight,
                    image: widget.data.image ?? '',
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(height: 10, color: ColorResources.white),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: 24,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data.title ?? '', style: FontFamily().bold),
                        SizedBox(height: 10),
                        HtmlWidget(
                          markdown.markdownToHtml(widget.data.description ?? ''),
                          textStyle: FontFamily().regular.copyWith(
                            fontSize: 12,
                            // color: ColorResources.primaryText.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
