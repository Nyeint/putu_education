// Path: widgets/loading_widgets.dart
import 'package:flutter/material.dart';

import '../config/color_resources.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingWidget({super.key, this.size = 60, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(color: ColorResources.primary),
        ),
      ),
    );
  }
}
