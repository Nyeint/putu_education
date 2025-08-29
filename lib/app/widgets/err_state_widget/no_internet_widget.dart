import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:putu_education/app/config/widget_extensions.dart';

class NoInternetWidget extends StatelessWidget {
  Function? fun;
  double? imgSize;
  NoInternetWidget({super.key, this.fun, this.imgSize});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: imgSize??context.width/2,
              height: imgSize??context.width/2,
              child: Lottie.asset("assets/anims/no-internet.json"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "No Connection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text(
              "Check your internet connection and try again!",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      // AppSettings.openAppSettings(type: );
                    },
                    child: const Text(
                      "Wifi Setting",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
