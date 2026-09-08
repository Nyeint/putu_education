// Path: widgets/word_tile_view.dart
import 'package:flutter/material.dart';
import '../../../app/config/config.dart';
import '../../widgets/item_decoration.dart';

/// A tappable word card from the scrambled word pool. Scales down briefly on
/// press for tactile feedback. Sibling of [LetterTileView] sized to its text
/// instead of a fixed square, since sentence words vary in length.
class WordTileView extends StatefulWidget {
  final String word;
  final VoidCallback? onTap;

  const WordTileView({super.key, required this.word, this.onTap});

  @override
  State<WordTileView> createState() => _WordTileViewState();
}

class _WordTileViewState extends State<WordTileView> {
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
          // No fixed height/alignment here: Align (which Container.alignment
          // wraps a child in) stretches to fill the cross axis when a
          // Wrap gives it unbounded width, forcing every tile onto its own
          // row. Vertical centering comes from symmetric padding instead, so
          // the tile still hugs its text width and multiple tiles can sit
          // side by side before wrapping to the next line.
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: context.width * 0.04),
          decoration: unselectedDecoration(),
          child: Text(
            widget.word,
            style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),
          ),
        ),
      ),
    );
  }
}
