// Path: poem/player_widget1.dart
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final bool compact;
  final bool showCompactArtwork;
  final String imageUrl;

  const PlayerWidget({
    required this.player,
    this.compact = false,
    this.showCompactArtwork = false,
    super.key,
    required this.imageUrl,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  String _formatClock(Duration d) {
    final totalSeconds = d.inSeconds.clamp(0, 1 << 31);
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Duration get _safeDuration => _duration ?? Duration.zero;

  Duration get _safePosition => _position ?? Duration.zero;

  // Clamp to [0, 1] instead of snapping back to 0 once position reaches (or
  // slightly overshoots, due to rounding) duration near the end of playback.
  double _sliderValue(Duration position, Duration duration) {
    if (duration.inMilliseconds <= 0) return 0.0;
    return (position.inMilliseconds / duration.inMilliseconds)
        .clamp(0.0, 1.0);
  }

  void _seekTo(double value, Duration duration) {
    final targetMs = (value * duration.inMilliseconds).round();
    final target = Duration(milliseconds: targetMs);
    // Reflect the drag immediately instead of waiting for the position
    // stream to catch up — otherwise the thumb visually snaps back to the
    // last known position until onPositionChanged fires again, which looks
    // like the slider doesn't respond at all.
    setState(() => _position = target);
    player.seek(target);
  }

  // Rewind/fast-forward by a fixed offset (e.g. ±10s), clamped to the track's
  // bounds instead of over/under-shooting past the start or end.
  void _seekBy(Duration offset) {
    final duration = _duration;
    if (duration == null || duration == Duration.zero) return;
    var target = _safePosition + offset;
    if (target < Duration.zero) target = Duration.zero;
    if (target > duration) target = duration;
    setState(() => _position = target);
    player.seek(target);
  }

  Widget _buildCompactBar(
    BuildContext context, {
    required bool showArtwork,
  }) {
    final duration = _safeDuration;
    final position = _safePosition;
    final remainingRaw = duration - position;
    final remaining = remainingRaw.isNegative ? Duration.zero : remainingRaw;

    final sliderValue = _sliderValue(position, duration);

    final compactSliderTheme = SliderTheme.of(context).copyWith(
      trackHeight: 2,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: ColorResources.white.withOpacity(0.92),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: ColorResources.lightBg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showArtwork) ...[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                // width: 44,
                // height: 44,
                imageUrl: widget.imageUrl,
                // imageUrl:
                //     'https://cdn.firstcry.com/education/2022/08/10192003/The-Foolish-Lion-And-The-Clever-Rabbit-Story-With-Moral-For-Kids.jpg',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 44,
                  height: 44,
                  color: ColorResources.lightBg,
                  child: Icon(
                    Icons.image,
                    color: ColorResources.primary,
                    size: 22,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 44,
                  height: 44,
                  color: ColorResources.lightBg,
                  child: Icon(
                    Icons.broken_image,
                    color: ColorResources.primary,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderTheme(
                  data: compactSliderTheme,
                  child: Slider(
                    activeColor: Colors.black,
                    inactiveColor: ColorResources.subText,
                    onChanged: (value) {
                      if (duration == Duration.zero) return;
                      _seekTo(value, duration);
                    },
                    value: sliderValue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatClock(position),
                      style: FontFamily().regular,
                    ),
                    Text(
                      _formatClock(duration),
                      style: FontFamily().regular,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            key: const Key('play_button'),
            onPressed: _isPlaying ? _pause : _play,
            icon: SvgPicture.asset(
              "assets/icons/${_isPlaying ? 'audio_pause' : 'audio_play'}.svg",
              width: 34,
            ),
            color: ColorResources.primary,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Use initial values from player
    _playerState = player.state;
    player.getDuration().then(
          (value) {
            if (!mounted) return;
            if (value != null && value != Duration.zero) {
              setState(() => _duration = value);
            }
          },
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final color = Theme.of(context).primaryColor;
    if (widget.compact) {
      return _buildCompactBar(
        context,
        showArtwork: widget.showCompactArtwork
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewPadding = MediaQuery.of(context).padding;
        final availableHeight =
        (constraints.maxHeight - viewPadding.vertical).clamp(0.0, 1 << 31);
        // If height becomes genuinely too small for the expanded controls,
        // fallback to compact to avoid overflow. Keep this threshold low so
        // we don't show a compact bar while the header is still tall (gap).
        if (availableHeight < 190) {
          return _buildCompactBar(context, showArtwork: false);
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorResources.lightBg,
                image: widget.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(widget.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8)
              ),
            ),
            SafeArea(
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final h =
                              constraints.maxHeight.clamp(0.0, 220.0);
                          if (h <= 0) return const SizedBox.shrink();
                          return ClipRRect(
                            // borderRadius:
                            //     const BorderRadius.all(Radius.circular(12)),
                            child: CachedNetworkImage(
                              height: h,
                              // width: double.infinity,
                              imageUrl: widget.imageUrl,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: CircularProgressIndicator(
                                    color: ColorResources.primary,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: h,
                                color: ColorResources.lightBg,
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: ColorResources.primary,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const SizedBox(height: 10),
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: ColorResources.subText,
                      onChanged: (value) {
                        final duration = _duration;
                        if (duration == null || duration == Duration.zero) {
                          return;
                        }
                        _seekTo(value, duration);
                      },
                      value: _sliderValue(_safePosition, _safeDuration),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _position != null ? _formatClock(_position!) : '0:00',
                          style: FontFamily().regular,
                        ),
                        Text(
                          _duration != null ?  _formatClock(_duration!) : '0:00',
                          style: FontFamily().regular,
                        ),
                      ],
                    ).pad(left: 6, right: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () =>  _seekBy(const Duration(seconds: -10)),
                          child: SizedBox(
                            width: context.width * 0.12,
                            child: Image.asset('assets/icons/rewind.png',),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () =>
                        //       _seekBy(const Duration(seconds: -10)),
                        //   icon: SvgPicture.asset(
                        //     "assets/icons/audio_previous.svg",
                        //     width: context.width * 0.09,
                        //   ),
                        //   color: ColorResources.primary,
                        // ),
                        IconButton(
                          key: const Key('play_button'),
                          onPressed: _isPlaying ? _pause : _play,
                          icon: SvgPicture.asset(
                            "assets/icons/${_isPlaying ? 'audio_pause' : 'audio_play'}.svg",
                            width: context.width * 0.18,
                          ),
                          color: ColorResources.primary,
                        ),
                        GestureDetector(
                          onTap: () =>  _seekBy(const Duration(seconds: 10)),
                          child: SizedBox(
                            width: context.width * 0.12,
                            child: Image.asset('assets/icons/skip_forward.png',)
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () =>
                        //       _seekBy(const Duration(seconds: 10)),
                        //   icon: SvgPicture.asset(
                        //     "assets/icons/audio_next.svg",
                        //     width: context.width * 0.09,
                        //   ),
                        //   color: ColorResources.primary,
                        // ),
                      ],
                    ),
                  ],
                ).pad(left: 16, right: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      // Ignore a zero/empty duration report so it can't clobber a
      // known-good value we already have (from the API or an earlier event).
      if (duration == Duration.zero) return;
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
      // Safety net: the source is often assigned after this widget's
      // initState (e.g. in a post-frame callback), so the initial
      // getDuration() call can resolve before the source is loaded and
      // onDurationChanged can be missed. Re-query once playback begins.
      if (state == PlayerState.playing &&
          (_duration == null || _duration == Duration.zero)) {
        player.getDuration().then((value) {
          if (mounted && value != null && value != Duration.zero) {
            setState(() => _duration = value);
          }
        });
      }
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }
}
