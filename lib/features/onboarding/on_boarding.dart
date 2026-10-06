// Path: onboarding/screen_one.dart
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/features/dashboard/dashboard.dart';
import 'package:putu_education/route/my_router.dart';

class ScreenOneView extends StatefulWidget {
  const ScreenOneView({super.key});

  @override
  State<ScreenOneView> createState() => _ScreenOneViewState();
}

class _ScreenOneViewState extends State<ScreenOneView> {
  late PageController _pageController;
  int _currentPage = 0;

  // Screen data
  final List<Map<String, dynamic>> _screens = [
    {
      'title': 'လွယ်လွယ်ကူကူ သင်ယူမယ်',
      'description':
          'အင်္ဂလိပ်စာ၊ မြန်မာစာနဲ့ သင်္ချာကို ဖုန်းတစ်လုံးနဲ့ အချိန်မရွေး လွယ်ကူစွာ သင်ယူနိုင်ပါတယ်။',
      'image': 'assets/images/easy_learning.png',
    },
    {
      'title': 'နားထောင်ရင်း သင်ယူမယ်',
      'description': 'ပုံပြင်၊ ကဗျာနဲ့ သီချင်းလေးတွေကို နားထောင်ရင်း ပျော်ပျော်ရွှင်ရွှင် သင်ယူနိုင်ပါတယ်။',
      'image': 'assets/images/listen_learn.png',
    },
    {
      'title': 'ကစားရင်း သင်ယူမယ်',
      'description': 'အင်္ဂလိပ်စာ၊ မြန်မာစာနဲ့ သင်္ချာကို ပျော်စရာဂိမ်းလေးတွေ ကစားရင်း သင်ယူနိုင်ပါတယ်။',
      'image': 'assets/images/playing_game.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF87CEEB), // Light blue background
        ),
        child: Column(
          children: [
            // Upper section with yellow background
            Container(
              height: context.height - 150,
              width: context.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 80),

                    // Logo and title
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/putu_logo.png',
                          width: context.width * 0.4,
                        ),
                        const SizedBox(width: 10),
                        // const Text(
                        //   'PuTu',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'serif',
                        //   ),
                        // ),
                      ],
                    ),

                    // const SizedBox(height: 10),

                    // Dynamic title button
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      decoration: BoxDecoration(
                        color: Color(0xffFFECB5),
                        // color: const Color(0xFFFFF8DC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        _screens[_currentPage]['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Dynamic description text
                    Text(
                      _screens[_currentPage]['description'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Dynamic image
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          _screens[_currentPage]['image'],
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Lower section with blue background
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: context.width,
              decoration: const BoxDecoration(
                color: Color(0xFF87CEEB), // Light blue background
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_currentPage < _screens.length - 1) {
                        setState(() {
                          _currentPage++;
                        });
                      } else {
                        // setState(() {
                        //   _currentPage=0;
                        // });

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardView()),
                                (route) => false);
                        // Handle completion action - go to next screen or finish onboarding
                      }
                    },
                    child: SizedBox(
                        width: 80,
                        child: Image.asset(
                          "assets/icons/next_button.png",
                        )),
                  ),

                  const SizedBox(height: 20),

                  // Skip button
                  if(_currentPage!=_screens.length-1)
                  GestureDetector(
                    onTap: () {
                      // Handle skip action
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardView()),
                              (route) => false);
                    },
                    child: const Text(
                      'ကျော်သွားမယ်',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
