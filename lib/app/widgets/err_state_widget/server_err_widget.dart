import 'package:flutter/material.dart';

class ServerErrWidget extends StatelessWidget {
  final Function? fun;
  final double? widgetSize;

  const ServerErrWidget({super.key, this.fun, this.widgetSize = 300});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Center(
          child: Text('500 INTERNAL SERVER ERROR!', style: TextStyle(fontSize: 18)),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
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
            ],
          ),
        )
      ],
    );
  }
}
