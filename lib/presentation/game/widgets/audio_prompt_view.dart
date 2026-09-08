// Path: widgets/audio_prompt_view.dart
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';
import '../../widgets/my_icon.dart';

/// Static "listen and arrange" prompt with a speaker icon that triggers
/// [onPlayAudio]. Distinct from [VoiceItemView] (which speaks arbitrary text
/// via TTS) — this always plays a pre-recorded `audio_url` clip.
class AudioPromptView extends StatelessWidget {
  final String description;
  final VoidCallback onPlayAudio;

  const AudioPromptView({super.key, required this.description, required this.onPlayAudio});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPlayAudio,
          child: MyIcon(iconName: 'volume'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, right: 20, left: 20),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/dotted_rectangle.png"), fit: BoxFit.fill),
            ),
            child: Text(description, style: FontFamily().semiBold),
          ),
        ),
      ],
    );
  }
}
