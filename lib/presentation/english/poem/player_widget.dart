import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
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

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://m.media-amazon.com/images/I/71HvRxH2bgL._AC_UF1000,1000_QL80_.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8), // Adjust the opacity for light effect
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: context.height*0.04,),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  width: context.width/3,
                  imageUrl: 'https://m.media-amazon.com/images/I/71HvRxH2bgL._AC_UF1000,1000_QL80_.jpg',
                  errorWidget: (context, url, error) => Center(child: new Icon(Icons.error)),
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      border: Border.all(color: ColorResources.lightBg),
                    ),
                    child:
                    Icon(Icons.image,color: ColorResources.primary, size: context.width/3.5,),
                  ),
                  // height: height,
                  // width: width,
                  fit: BoxFit.cover,
                ),
              ),
              Slider(
                activeColor: Colors.black,
                inactiveColor: ColorResources.subText,
                onChanged: (value) {
                  final duration = _duration;
                  if (duration == null) {
                    return;
                  }
                  final position = value * duration.inMilliseconds;
                  player.seek(Duration(milliseconds: position.round()));
                },
                value: (_position != null &&
                    _duration != null &&
                    _position!.inMilliseconds > 0 &&
                    _position!.inMilliseconds < _duration!.inMilliseconds)
                    ? _position!.inMilliseconds / _duration!.inMilliseconds
                    : 0.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( _position != null
                        ?_positionText:'0:00', style: FontFamily().regular,),
                    Text( _position != null
                        ?_durationText:'0:00', style: FontFamily().regular),
                  ]
          
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: (){},
                    // iconSize: 48.0,
                    // icon: Icon(_isPlaying ?Icons.pause:Icons.play_arrow),
                    icon: SvgPicture.asset("assets/icons/audio_previous.svg", width: context.width*0.09),
                    color: ColorResources.primary,
                  ),
                  IconButton(
                    key: const Key('play_button'),
                    onPressed: _isPlaying ? _pause : _play,
                    // iconSize: context.width*,
                    // icon: Icon(_isPlaying ?Icons.pause:Icons.play_arrow),
                    icon: SvgPicture.asset("assets/icons/${_isPlaying ? 'audio_pause' : 'audio_play'}.svg",
                    width: context.width*0.18,
                    ),
                    color: ColorResources.primary,
                  ),
                  IconButton(
                    onPressed: (){},
                    // iconSize: 48.0,
                    // icon: Icon(_isPlaying ?Icons.pause:Icons.play_arrow),
                    icon: SvgPicture.asset("assets/icons/audio_next.svg",
                      width: context.width*0.09,
                    ),
                    color: ColorResources.primary,
                  ),
                ],
              ),
          
            ],
          ).pad(left: 16, right: 16),
        )
      ],
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

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}