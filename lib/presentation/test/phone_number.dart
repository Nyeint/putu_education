import 'dart:async';
import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String currentText = '';
  int times = 0;
  bool isFirst = true;
  Timer? debounceTimer;

  Map<String, List<String>> buttonMappings = {
    '1': ['&', '\'', '('],
    '2': ['A', 'B', 'C'],
    '3': ['D', 'E', 'F'],
    '4': ['G', 'H', 'I'],
    '5': ['J', 'K', 'L'],
    '6': ['M', 'N', 'O'],
    '7': ['P', 'Q', 'R', 'S'],
    '8': ['T', 'U', 'V'],
    '9': ['W', 'X', 'Y', 'Z'],
    '0': [' '],
    '*': ['x'],
    '#': ['send'],
  };

  void handleKeyPress(String key) {
    if (key == '*') {
      if (currentText.isNotEmpty) {
        currentText = currentText.substring(0, currentText.length - 1);
      }
    } else if (key == '#') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("You've sent '$currentText'")));
      currentText = '';
    } else {
      List<String> letters = buttonMappings[key]!;
      if (currentText.isNotEmpty &&
          letters.contains(currentText[currentText.length - 1])) {
        if (isFirst) {
          currentText += letters[0];
        } else {
          ++times;
          currentText = currentText.substring(0, currentText.length - 1);
          currentText += letters[times % letters.length];
        }
      } else {
        times = 0;
        currentText += letters[0];
      }
      isFirst = false;
    }

    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(seconds: 1), () {
      setState(() {
        times = 0;
        isFirst = true;
      });
    });

    setState(() {});
  }

  Widget buildButton(String buttonNumber, {Widget? widget}) {
    return GestureDetector(
      onTap: () {
        handleKeyPress(buttonNumber);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff354063), width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonNumber,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: buttonMappings[buttonNumber]!
                  .asMap()
                  .entries
                  .map((e) {
                return widget ??
                    Text(
                      e.value.toLowerCase(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4F5F92),
      appBar: AppBar(
        title: Text('Phone Pad Coding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffADBFBB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                currentText,
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton('*', widget: Icon(Icons.backspace)),
                    buildButton('0', widget: Icon(Icons.space_bar)),
                    buildButton('#', widget: Icon(Icons.send, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
