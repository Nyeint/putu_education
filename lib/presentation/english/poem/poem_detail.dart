import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/english/poem/player_widget.dart';
import '../../widgets/my_appbar.dart';

class PoemDetailView extends StatefulWidget {
  const PoemDetailView({super.key});

  @override
  State<PoemDetailView> createState() => _PoemDetailViewState();
}

class _PlayerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final AudioPlayer player;
  final double minHeight;
  final double maxHeight;

  _PlayerHeaderDelegate({
    required this.player,
    required this.minHeight,
    required this.maxHeight,
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

class _PoemDetailViewState extends State<PoemDetailView> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await player.setSource(AssetSource('ambient_c_motion.mp3'));
      await player.setSourceUrl('https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg');
      await player.resume();
    });
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
        child: Scaffold(
          backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: 'A Little',
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
                        Text('A Little Turtle', style: FontFamily().bold),
                        SizedBox(height: 10),
                        Text(
                          'By reading the A Little Turtle poem, your little one would understand the characteristics of a turtle in just a few lines. ',
                          style: FontFamily().regular,
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '1 page | 2 mins',
                            style: FontFamily().regular,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: context.width,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ColorResources.lightBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text(
                            'There was a little turtle.\nHe lived in a box.\nHe swam in a puddle.\nHe climbed on the rocks.\n'
                                'He snapped at a mosquito.\n'
                                'He snapped at a flea.\nHe snapped at a minnow.\nAnd he snapped at me.\n'
                                'He caught the mosquito.\nHe caught the flea.\nHe caught the minnow.\nBut he didn’t catch me.'
                                'There was a little turtle.\nHe lived in a box.\nHe swam in a puddle.\nHe climbed on the rocks.\n'
                                'He snapped at a mosquito.\n'
                                'He snapped at a flea.\nHe snapped at a minnow.\nAnd he snapped at me.\n'
                                'He caught the mosquito.\nHe caught the flea.\nHe caught the minnow.\nBut he didn’t catch me.'
                                'There was a little turtle.\nHe lived in a box.\nHe swam in a puddle.\nHe climbed on the rocks.\n'
                                'He snapped at a mosquito.\n'
                                'He snapped at a flea.\nHe snapped at a minnow.\nAnd he snapped at me.\n'
                                'He caught the mosquito.\nHe caught the flea.\nHe caught the minnow.\nBut he didn’t catch me.'
                                'There was a little turtle.\nHe lived in a box.\nHe swam in a puddle.\nHe climbed on the rocks.\n'
                                'He snapped at a mosquito.\n'
                                'He snapped at a flea.\nHe snapped at a minnow.\nAnd he snapped at me.\n'
                                'He caught the mosquito.\nHe caught the flea.\nHe caught the minnow.\nBut he didn’t catch me.',
                            textAlign: TextAlign.center,
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
