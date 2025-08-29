
import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  
  Map<String,dynamic>? data;
  MoreWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          if (data!["target"] == "send-request")
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/icons/denied_removebg.png',
                  fit: BoxFit.fill,
                )),
          Text(
            data!['message'].toString(),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),

          // send-request
          if (data!["target"] == "send-request")
            const SizedBox(
              height: 10,
            ),
          if (data!["target"] == "send-request")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: () {
                    // context.offAll(StarFishPage());
                  },
                  child: const Text("BACK TO HOME",style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: () {
                    // context.offAll(StarFishPage());
                  },
                  child: const Text("SEND REQUEST",style: TextStyle(color: Colors.white),),
                ),
              ],
            )
        ],
      ),
    );
  }
}
