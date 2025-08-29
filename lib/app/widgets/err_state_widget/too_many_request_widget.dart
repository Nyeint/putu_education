import 'package:flutter/material.dart';

class TooManyRequestWidget extends StatelessWidget {
  Function? fun;

  TooManyRequestWidget({super.key, this.fun});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.info_outline,
          color: Colors.red,
        ),
        SizedBox(
          height: 20,
        ),
        Center(child: Text("Too Many Request! Please Try Again Later")),
      ],
    );
  }
}
