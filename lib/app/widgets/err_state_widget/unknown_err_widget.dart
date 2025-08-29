import 'package:flutter/material.dart';

class UnknownErrWidget extends StatelessWidget {
  Function? fun;
  String? message;
  double? widgetSize;

  UnknownErrWidget({super.key, this.fun, this.message, this.widgetSize = 300});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: widgetSize,
            height: widgetSize,
            child: Image.asset("assets/images/unknown.png", errorBuilder: (c, s, t) {
              return const Icon(
                Icons.info_outline,
                color: Colors.grey,
              );
            }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: message == null
                ? Text(
                    "Unknown Error!...",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    message!,
                    textAlign: TextAlign.center,
                  )),
        const SizedBox(
          height: 20,
        ),
        fun == null
            ? Container()
            : Center(
                child: SizedBox(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      fun!();
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
