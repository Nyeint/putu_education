// Path: widgets/success_feedback_view.dart
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';

/// Brief celebratory badge shown for ~1s while the game auto-advances after
/// a correct answer.
class SuccessFeedbackView extends StatelessWidget {
  final bool visible;

  const SuccessFeedbackView({super.key, required this.visible});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedScale(
          scale: visible ? 1 : 0.6,
          duration: const Duration(milliseconds: 200),
          curve: Curves.elasticOut,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: ColorResources.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Icon(Icons.check_rounded, color: ColorResources.primary, size: 56),
          ),
        ),
      ),
    );
  }
}
