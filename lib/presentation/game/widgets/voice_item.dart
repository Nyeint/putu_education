import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../app/config/config.dart';
import '../../widgets/my_icon.dart';

class VoiceItemView extends StatefulWidget {
  String name;
  String description;
  VoiceItemView({super.key, required this.name, required this.description});

  @override
  State<VoiceItemView> createState() => _VoiceItemViewState();
}

class _VoiceItemViewState extends State<VoiceItemView> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTts();
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () async => await flutterTts.speak(widget.name),
            child: MyIcon(iconName: 'volume',)),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
              // width: context.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/dotted_rectangle.png",), fit: BoxFit.fill),
              ),
              child: Text(widget.description, style: FontFamily().semiBold,)
          ),
        )
      ],
    );
  }
}
