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
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorResources.background,
          appBar: MyAppBar(
            titleWithGoBack: 'A Little',
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/light_background.png",),
                    fit: BoxFit.fill),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: context.height/2,
                      child: PlayerWidget(player: player)),
                  Container(height: 10, color: ColorResources.white,),
                  Column(
                    children: [
                      Text('A Little Turtle', style: FontFamily().bold,),
                      SizedBox(height: 10,),
                      Text('By reading the A Little Turtle poem, your little one would understand the characteristics of a turtle in just a few lines. ',
                      style: FontFamily().regular,),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('1 page | 2 mins', style: FontFamily().regular),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: context.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorResources.lightBg,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child:
                        Text('There was a little turtle.\nHe lived in a box.\nHe swam in a puddle.\nHe climbed on the rocks.\n'
                            'He snapped at a mosquito.\n'
                            'He snapped at a flea.\nHe snapped at a minnow.\nAnd he snapped at me.\n'
                            'He caught the mosquito.\nHe caught the flea.\nHe caught the minnow.\nBut he didn’t catch me.',
                        textAlign: TextAlign.center,)
                      ),
                    ],
                  ).pad(left: 16, right: 16,top: 24, bottom: 24),
                ],
              ),
            ),
          ),
        ));
  }
}
