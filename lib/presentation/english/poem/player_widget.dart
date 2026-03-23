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

  const PlayerWidget({
    required this.player,
    this.compact = false,
    this.showCompactArtwork = false,
    super.key,
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

  Widget _buildCompactBar(
    BuildContext context, {
    required bool showArtwork,
  }) {
    final duration = _safeDuration;
    final position = _safePosition;
    final remainingRaw = duration - position;
    final remaining = remainingRaw.isNegative ? Duration.zero : remainingRaw;

    final sliderValue = (position.inMilliseconds > 0 &&
            duration.inMilliseconds > 0 &&
            position.inMilliseconds < duration.inMilliseconds)
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    final compactSliderTheme = SliderTheme.of(context).copyWith(
      trackHeight: 2,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                width: 44,
                height: 44,
                imageUrl:
                    'https://cdn.firstcry.com/education/2022/08/10192003/The-Foolish-Lion-And-The-Clever-Rabbit-Story-With-Moral-For-Kids.jpg',
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
                      final targetMs = (value * duration.inMilliseconds).round();
                      player.seek(Duration(milliseconds: targetMs));
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
          (value) => setState(() {
            _duration = value;
          }),
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
        // Compute artwork height from the actual available header height,
        // reserving space for controls so the Column can never overflow.
        //
        // Approx fixed vertical needs:
        // - spacing (10)
        // - slider (48)
        // - time row (24)
        // - buttons row (72)  (IconButton + padding can exceed 60)
        // - a little breathing room (16)
        const reservedControlsHeight = 10 + 48 + 24 + 72 + 16;
        final computedArtwork =
        (availableHeight - reservedControlsHeight).clamp(0.0, 220.0);
        final artworkHeight = computedArtwork.toDouble();

        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.firstcry.com/education/2022/08/10192003/The-Foolish-Lion-And-The-Clever-Rabbit-Story-With-Moral-For-Kids.jpg'),
                    fit: BoxFit.cover
                ),
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
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: CachedNetworkImage(
                        height: artworkHeight,
                        width: double.infinity,
                        imageUrl:
                        'https://cdn.firstcry.com/education/2022/08/10192003/The-Foolish-Lion-And-The-Clever-Rabbit-Story-With-Moral-For-Kids.jpg',
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
                          height: artworkHeight,
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
                    ),
                    const SizedBox(height: 10),
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: ColorResources.subText,
                      onChanged: (value) {
                        final duration = _duration;
                        if (duration == null) return;
                        final position = value * duration.inMilliseconds;
                        player.seek(Duration(milliseconds: position.round()));
                      },
                      value: (_position != null &&
                          _duration != null &&
                          _position!.inMilliseconds > 0 &&
                          _position!.inMilliseconds <
                              _duration!.inMilliseconds)
                          ? _position!.inMilliseconds /
                          _duration!.inMilliseconds
                          : 0.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _position != null ? _positionText : '0:00',
                          style: FontFamily().regular,
                        ),
                        Text(
                          _position != null ? _durationText : '0:00',
                          style: FontFamily().regular,
                        ),
                      ],
                    ).pad(left: 6, right: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/audio_previous.svg",
                            width: context.width * 0.09,
                          ),
                          color: ColorResources.primary,
                        ),
                        IconButton(
                          key: const Key('play_button'),
                          onPressed: _isPlaying ? _pause : _play,
                          icon: SvgPicture.asset(
                            "assets/icons/${_isPlaying ? 'audio_pause' : 'audio_play'}.svg",
                            width: context.width * 0.18,
                          ),
                          color: ColorResources.primary,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/audio_next.svg",
                            width: context.width * 0.09,
                          ),
                          color: ColorResources.primary,
                        ),
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
