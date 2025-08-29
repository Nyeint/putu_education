import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  double? widgetSize;
  NotFoundWidget({super.key, this.widgetSize = 300});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: Text('404 NOT FOUND',style: TextStyle(fontSize: 17),),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Oops!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "We couldn't find the page you looking for",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
