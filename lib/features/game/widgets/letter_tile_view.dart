// Path: widgets/letter_tile_view.dart
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

/// A tappable letter card from the scrambled letter pool. Scales down
/// briefly on press for tactile feedback.
class LetterTileView extends StatefulWidget {
  final String letter;
  final double size;
  final VoidCallback? onTap;

  const LetterTileView({super.key, required this.letter, required this.size, this.onTap});

  @override
  State<LetterTileView> createState() => _LetterTileViewState();
}

class _LetterTileViewState extends State<LetterTileView> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          decoration: unselectedDecoration(),
          child: Text(
            widget.letter.toUpperCase(),
            style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),
          ),
        ),
      ),
    );
  }
}
