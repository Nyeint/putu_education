// Path: game/widgets/choose_questions_alert.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';

/// Shown at game start when a cached question set already exists, letting
/// the player reuse it or force a fresh fetch. Returns true for "new
/// questions" (forceRefresh), false for "old questions" (use cache).
Future<bool> showChooseQuestionsAlert(BuildContext context) async {
  final bearSize = context.width * 0.3;
  final result = await showDialog<bool>(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.6),
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            // margin: EdgeInsets.only(top: bearSize * 0.5),
            padding: EdgeInsets.fromLTRB(20, bearSize * 0.55, 20, 20),
            decoration: BoxDecoration(
              color: ColorResources.lightBg,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: ColorResources.primary, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(tr('choose_questions'), style: FontFamily().bold.copyWith(fontSize: 20)),
                SizedBox(height: 4),
                Text(tr('choose_questions_desc'),
                    style: FontFamily().medium.copyWith(fontSize: 13), textAlign: TextAlign.center,),
                SizedBox(height: 20),
                Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ChoiceCard(
                    // color: ColorResources.math,
                    color: Colors.green,
                    image: 'assets/icons/practice_again.png',
                    // title: tr('play_old_questions'),
                    title: 'Practice Again',
                    desc: tr('play_old_questions_desc'),
                    onTap: () => Navigator.pop(context, false),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _ChoiceCard(
                    // color: ColorResources.fruit_veg,
                    color: Colors.lightBlue,
                    image: 'assets/icons/new_question.png',
                    // title: tr('play_new_questions'),
                    title: 'New Questions',
                    desc: tr('play_new_questions_desc'),
                    onTap: () => Navigator.pop(context, true),
                  ),
                ),
              ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Image.asset('assets/images/bear_wink.png', width: bearSize),
          ),
          // Positioned(
          //   // top: bearSize * 0.5 + 4,
          //   top: -20,
          //   right: -10,
          //   child: GestureDetector(
          //     onTap: () => Navigator.pop(context, false),
          //     child: Container(
          //       padding: EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         shape: BoxShape.circle,
          //         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          //         border: Border.all(color: ColorResources.primary, width: 2),
          //       ),
          //       child: Icon(Icons.close_rounded, weight: 20, color: ColorResources.border, size: 20),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
  return result ?? false;
}

class _ChoiceCard extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.color,
    required this.image,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [

                // SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FontFamily().semiBold.copyWith(color: Colors.white, fontSize: 13),
                  ),
                ).pad(top: 55),
                Image.asset(image, height: 70),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: FontFamily().regular.copyWith(color: Colors.black87, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
