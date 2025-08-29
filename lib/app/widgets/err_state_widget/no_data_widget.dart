import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          // SizedBox(
          //   height: size.height * 0.20,
          // ),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/images/empty_message.png',),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            tr('no_data'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
