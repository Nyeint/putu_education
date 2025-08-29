import 'package:flutter/material.dart';

class ServerMaintenance extends StatelessWidget {
  final Function? fun;
  final double? widgetSize;

  const ServerMaintenance({super.key, this.fun, this.widgetSize = 200});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(child: SizedBox(width: widgetSize, height: widgetSize, child: Image.asset("assets/images/503.png"))),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            "System Maintenance...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ),
        const Center(child: Text("Service Unavailable", style: TextStyle(fontSize: 15))),
      ],
    );
  }
}
